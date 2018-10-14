# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  describe 'GET /:id' do
    let!(:links)      { create_list(:link, 10) }
    let(:url)         { links.first.url }
    let(:vanity_url)  { links.first.short_url }

    before { get :show, params: { id: vanity_url }}

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
    before { post :create, params: { url: "http://www.blacktangent.com" }}

    context 'when creating first record' do
      it 'short_link will be set to 000001' do
        expect(Link.first.short_url).to eq('000001')
      end
    end

    context 'when creating any record after first record' do
      it 'short_url will be set to a 6 character string' do
        post :create, params: { url: "http://google.com" } 
        expect(Link.last.short_url).to match(/^\w{6}$/)
      end

      it 'short_url should not be the same as first_record' do
        post :create, params: { url: "http://google.com" } 
        expect(Link.last.short_url).to_not eq(Link.first.short_url)
      end
    end
  end
end
