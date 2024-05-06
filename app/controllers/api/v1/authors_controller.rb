# app/controllers/api/v1/authors_controller.rb
module Api
  module V1
    class AuthorsController < ApplicationController
      include ActionController::HttpAuthentication::Token
      before_action :authenticate_user, only: %i[index create]

      MAX_PAGINATION_LIMIT = 50

      def index
        authors = Author.limit(max_limit).offset(params[:offset])
        render json: authors.as_json(methods: :name)
      end

      def create
        author = Author.new(author_params)
        if author.save
          render json: author, status: :created
        else
          render json: author.errors, status: :unprocessable_entity
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

      def author_params
        params.require(:author).permit(:name, :birthdate)
      end

      def max_limit
        [params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i, MAX_PAGINATION_LIMIT].min
      end
    end
  end
end
