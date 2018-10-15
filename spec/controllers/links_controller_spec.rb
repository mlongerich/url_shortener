# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  describe 'GET /:id' do
    let!(:links)      { create_list(:link, 10) }
    let(:url)         { links.first.url }
    let(:vanity_url)  { links.first.short_url }

    before { get :show, params: { id: vanity_url } }

    context 'when the record exists' do
      it 'redirects to the link' do
        expect(response).to redirect_to(url)
      end

      it 'returns status code 302' do
        expect(response).to have_http_status(302)
      end
    end

    context 'when the record does not exist' do
      let(:vanity_url) { 100 }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Short url is invalid/)
      end
    end
  end

  describe 'POST /add' do
    before { post :create, params: { url: 'http://www.blacktangent.com' } }

    context 'when creating first record' do
      it 'short_link will be set to 000001' do
        expect(Link.first.short_url).to eq('000001')
      end
    end

    context 'when creating any record after first record' do
      it 'short_url will be set to a 6 character string' do
        post :create, params: { url: 'http://google.com' }
        expect(Link.last.short_url).to match(/^\w{6}$/)
      end

      it 'short_url should not be the same as first_record' do
        post :create, params: { url: 'http://google.com' }
        expect(Link.last.short_url).to_not eq(Link.first.short_url)
      end
    end

    context 'when creating a record with whitespace issuses' do
      it 'should strip leading whitespace' do
        post :create, params: { url: ' http://google.com' }
        expect(Link.last.url).to eq('http://google.com')
      end
      it 'should strip trailing whitespace' do
        post :create, params: { url: 'http://google.com ' }
        expect(Link.last.url).to eq('http://google.com')
      end
      it 'should remove leading %20' do
        post :create, params: { url: '%20http://google.com' }
        expect(Link.last.url).to eq('http://google.com')
      end
      it 'should removed trailing %20' do
        post :create, params: { url: 'http://google.com%20' }
        expect(Link.last.url).to eq('http://google.com')
      end
      it 'should keep non-leading and non-trailing %20' do
        post :create, params: { url: 'http://google.com/this%20should%20work' }
        expect(Link.last.url).to eq('http://google.com/this%20should%20work')
      end
      it 'it should handle combination of all of the above' do
        post :create, params: { url: ' %20 http://google.com/this%20should%20work %20 %20 %20' }
        expect(Link.last.url).to eq('http://google.com/this%20should%20work')
      end
    end
    context 'when creating issues with special characters' do
      it 'it should convert special characters to url safe' do
        post :create, params: { url: 'http://example.com/?a=\11\15' }
        expect(Link.last.url).to eq('http://example.com/?a=%5C11%5C15')
      end
    end
  end
end
