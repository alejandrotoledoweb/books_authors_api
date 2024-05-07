module Api
  module V1
    class UsersController < ApplicationController
      include ActionController::HttpAuthentication::Token
      before_action :authenticate_user, only: %i[create]

      def create
        user = User.new(user_params)
        if user.save
          render json: user, status: :created
        else
          render json: user.errors, status: :unprocessable_entity
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

      def user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
      end
    end
  end
end
