# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Link API', type: :request do
  let!(:links) { create_list(:link, 10) }
  let(:vanity_url) { links.first.short_url }

  describe 'GET /links' do
    before { get '/links' }

    it 'returns links' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /add' do
    let(:valid_attributes) { { url: 'https://blacktangent.com/' } }
    context 'when new record request is valid' do
      before { post '/add', params: valid_attributes }

      it 'creates a url' do
        expect(json['url']).to eq('https://blacktangent.com/')
      end

      it 'creates a short_url' do
        expect(json['short_url']).to match(%r{localhost:3000/\w{6}$})
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when new record request already exists' do
      before { post '/add', params: valid_attributes }

      it 'does not creates a new url' do
        first_url = json['url']
        post '/add', params: valid_attributes
        expect(json['url']).to eq(first_url)
      end

      it 'does not create a new short_url' do
        first_short_url = json['short_url']
        post '/add', params: valid_attributes
        expect(json['short_url']).to eq(first_short_url)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post '/add', params: { url: nil } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message if blank' do
        expect(response.body)
          .to match(/Validation failed: Url can't be blank/)
      end

      it 'returns a validation failure message if invalid url' do
        post '/add', params: { url: 'blacktangent' }
        expect(response.body)
          .to match(/Validation failed: Url is invalid/)
      end
    end
  end

  # Test suite for DELETE /links/:id
  describe 'DELETE /links/:id' do
    before { delete "/links/#{vanity_url}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
