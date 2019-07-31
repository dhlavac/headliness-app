require 'rails_helper'

RSpec.describe 'Headlines API', type: :request do
  # Initialize test data
  let!(:headlines) { create_list(:headline, 10) }
  let(:headline_id) { headlines.first.id }
  # Test suite for GET /headlines
  describe 'GET /headlines' do
    before { get '/api/v1/headlines' }

    it 'returns headlines' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1//headlines/:id
  describe 'GET /api/v1/headlines/:id' do
    before { get "/api/v1/headlines/#{headline_id}" }

    context 'when the record exists' do
      it 'returns headline' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(headline_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:headline_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Headline/)
      end
    end
  end

  # Test suite for POST /api/v1//headlines
  describe 'POST /headlines' do
    # valid payload
    let(:valid_attributes) { { text: 'Lorem ipsum dolor si amet', origin: 'Oz the Great', publisher: 'Mlada fronta' } }

    context 'when the request is valid' do
      before { post '/api/v1/headlines', params: valid_attributes }

      it 'creates a headline' do
        expect(json['message']).to include('Successfully created')
        expect(json['data']['text']).to eq('Lorem ipsum dolor si amet')
        expect(json['data']['origin']).to eq('Oz the Great')
        expect(json['data']['publisher']).to eq('Mlada fronta')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/headlines', params: { publisher: 'Bad one' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Text can't be blank/)
      end
    end
  end

  # Test suite for PUT /api/v1/headlines/:id
  describe 'PUT /api/v1/headlines/:id' do
    let(:valid_attributes) { { text: 'IBM buy Red Hat' } }

    context 'when the record exists' do
      before { put "/api/v1/headlines/#{headline_id}", params: valid_attributes }

      it 'updates the record' do
        expect(json['message']).to include("Successfully updated")
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for DELETE /api/v1//headlines/:id
  describe 'DELETE /api/v1/headlines/:id' do
    before { delete "/api/v1/headlines/#{headline_id}" }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
