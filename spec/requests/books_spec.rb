require 'rails_helper'
require 'json'

RSpec.describe Book, type: :request do


  describe 'GET /index' do
    let!(:user) { FactoryBot.create(:user, username: 'user1', password: 'foobar') }
    let(:author) { FactoryBot.create(:author, name: 'Jane Doe', birthdate: '1980-12-05') }
    let(:book) { FactoryBot.create(:book, title: 'Ruby on Rails First Edition', author: author) }
    let(:book2) { FactoryBot.create(:book, title: 'Ruby on Rails Second Edition', author: author) }
    let!(:valid_headers) { auth_headers(user) }

    it 'returns a successful response' do
      get '/api/v1/books', headers: valid_headers, params: { limit: 10, offset: 0 }
      expect(response).to have_http_status(:ok)
      expect(response.body.size).to eq(2)
    end
  end

  describe 'POST /create' do
    let!(:user) { FactoryBot.create(:user, username: 'user1', password: 'foobar') }
    let!(:token) { AuthenticationTokenService.encode(user.id) }
    let!(:author) { FactoryBot.create(:author, name: 'Jane Doe', birthdate: '1980-12-05') }
    let!(:book_params) { { book: { title: 'New Book', published_year: 2022, author_id: author.id } } }

    it 'creates a new book' do
      expect {
        post '/api/v1/books', params: book_params, headers: { 'Authorization' => "Bearer #{token}" }
      }.to change{ Book.count }.from(0).to(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'GET /show' do

    let!(:user) { FactoryBot.create(:user, username: 'user1', password: 'foobar') }
    let!(:token) { AuthenticationTokenService.encode(user.id) }
    let!(:author) { FactoryBot.create(:author, name: 'Jane Doe', birthdate: '1980-12-05') }
    let(:book) { FactoryBot.create(:book, title: 'Ruby on Rails First Edition', author: author) }
    let!(:valid_headers) { auth_headers(user) }

    it 'returns the book details' do
      get '/api/v1/books/show', headers: valid_headers, params: {title: book.title}
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['title']).to eq(book.title)
    end
  end

  describe 'DELETE /destroy' do

    let!(:user) { FactoryBot.create(:user, username: 'user1', password: 'foobar') }
    let!(:author) { FactoryBot.create(:author, name: 'Jane Doe', birthdate: '1980-12-05') }
    let(:book) { FactoryBot.create(:book, title: 'Ruby on Rails First Edition', author: author) }
    let!(:valid_headers) { auth_headers(user) }
    it 'deletes the book' do
      delete api_v1_book_path(book), headers: valid_headers
      expect(response).to have_http_status(:ok)
      expect(Book.find_by(id: book.id)).to be_nil
    end
  end
end
