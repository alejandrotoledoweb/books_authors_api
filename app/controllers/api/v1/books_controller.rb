# app/controllers/api/v1/books_controller.rb
module Api
  module V1
    class BooksController < ApplicationController
      include ActionController::HttpAuthentication::Token
      before_action :authenticate_user, only: %i[index show create destroy]

      MAX_PAGINATION_LIMIT = 50

      def index
        books = Book.limit(max_limit).offset(params[:offset])
        render json: as_json(books)
      end

      def show
        if params[:title].present?
          title = params[:title].downcase
          book = Book.find_by('lower(title) = ?', title)
          if book
            render json: book_as_json(book)
          else
            render json: { error: 'Book not found' }, status: :not_found
          end
        else
          render json: { error: 'Title parameter is missing' }, status: :bad_request
        end
      end

      def create
        book = Book.new(book_params)
        if book.save
          render json: book, status: :created
        else
          render json: book.errors, status: :unprocessable_entity
        end
      end

      def destroy
        book = Book.find_by(id: params[:id])
        if book
          book.destroy
          render json: { message: 'Book was successfully destroyed.' }, status: :ok
        else
          render json: { error: 'Book not found' }, status: :not_found
        end
      end

      private

      def authenticate_user
        token, _options = token_and_options(request)
        user_id = AuthenticationTokenService.decode(token)
        User.find(user_id)
      rescue ActiveRecord::RecordNotFound, JWT::DecodeError
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end

      def book_params
        params.require(:book).permit(:title, :published_year, :author_id)
      end

      def as_json(books)
        books.map do |book|
          {
            id: book.id,
            title: book.title,
            author_name: book.author.name,
            published_year: book.published_year
          }
        end
      end

      def book_as_json(book)
        {
          id: book.id,
          title: book.title,
          author_name: book.author&.name,
          published_year: book.published_year
        }
      end

      def max_limit
        [params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i, MAX_PAGINATION_LIMIT].min
      end
    end
  end
end
