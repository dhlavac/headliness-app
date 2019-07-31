require 'rails_helper'

RSpec.describe 'Comments API' do
  # Initialize the test data
  let!(:headline) { create(:headline) }
  let!(:comments) { create_list(:comment, 20, headline_id: headline.id) }
  let(:headline_id) { headline.id }
  let(:id) { comments.first.id }

  # Test suite for GET /api/v1/headlines/:headline_id/comments
  describe 'GET /api/v1headlines/:headline_id/comments' do
    before { get "/api/v1/headlines/#{headline_id}/comments" }

    context 'when comments exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all comments ' do
        expect(json.size).to eq(20)
      end
    end

    context 'when comments does not exist' do
      let(:headline_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Headline/)
      end
    end
  end

  # Test suite for GET /api/v1/headlines/:headline_id/comments/:id
  describe 'GET /api/v1/headlines/:headline_id/comments/:id' do
    before { get "/api/v1/headlines/#{headline_id}/comments/#{id}" }

    context 'when headlines comment exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the comment' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when headlines comment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Comment/)
      end
    end
  end

  # Test suite for POST /api/v1/headlines/:headline_id/comments
  describe "POST /api/v1/headlines/:headline_id/comments" do
    let(:valid_attributes) { { author: 'Mr. Andernson', up_vote: 100, down_vote: 1, text: 'Welcome to Matrix' } }

    context 'when request attributes are valid' do
      before { post "/api/v1/headlines/#{headline_id}/comments", params: valid_attributes }

      it 'returns status code 200' do
        expect(json['message']).to include('Successfully created')
        expect(json['data']['author']).to eq('Mr. Andernson')
        expect(json['data']['down_vote']).to eq(1)
        expect(json['data']['up_vote']).to eq(100)
        expect(response).to have_http_status(200)
      end
    end

    context 'when an invalid request' do
      before { post "/api/v1/headlines/#{headline_id}/comments", params: {author: 'Mr. Andernson', up_vote: 100, down_vote: 1} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Text can't be blank/)
      end
    end
  end

  # Test suite for PUT /api/v1/headlines/:headline_id/comments/:id
  describe 'PUT /api/v1/headlines/:headline_id/comments/:id' do
    let(:valid_attributes) { { down_vote: 5 } }

    before { put "/api/v1/headlines/#{headline_id}/comments/#{id}", params: valid_attributes }

    context 'when comment exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the comment' do
        updated_comment = Comment.find(id)
        expect(updated_comment.down_vote).to match(5)
      end
    end

    context 'when the comment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Comment/)
      end
    end
  end

  # Test suite for DELETE /api/v1/headlines/:headline_id/comments/:id
  describe 'DELETE /api/v1/headlines/:headline_id/comments/:id' do
    before { delete "/api/v1/headlines/#{headline_id}/comments/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(200)
    end
  end
end
