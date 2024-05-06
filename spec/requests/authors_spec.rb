require 'rails_helper'
require 'json'

RSpec.describe 'Authors', type: :request do
  let!(:user) { FactoryBot.create(:user, username: 'user1', password: 'foobar') }
  let!(:valid_headers) { auth_headers(user) }

  describe 'GET /index' do
    let!(:authors) { FactoryBot.create_list(:author, 3, name: 'John Doe', birthdate: '1980-12-05') }

    it 'returns all authors' do
      get '/api/v1/authors', headers: valid_headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'POST /create' do
    let!(:author_params) { { author: { name: 'Jane Smith', birthdate: '1990-07-12' } } }

    it 'creates a new author' do
      expect {
        post '/api/v1/authors', params: author_params, headers: valid_headers
      }.to change(Author, :count).from(0).to(1)
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['name']).to eq('Jane Smith')
    end
  end
end
