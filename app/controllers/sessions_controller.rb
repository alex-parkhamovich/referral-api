# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authorize_request

  def create
    if auth_token
      render json: { auth_token: auth_token }
    else
      render json: { error: 'Authentication error' }, status: :unauthorized
    end
  end

  private

  def sign_in_params
    params.permit(:email, :password)
  end

  def auth_token
    @auth_token ||= Authenticator.new(
      email: sign_in_params[:email],
      password: sign_in_params[:password]
    ).call
  end
end
