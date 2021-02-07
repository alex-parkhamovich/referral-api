# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate_request

  def create
    if auth_token
      render json: { auth_token: auth_token }
    else
      render json: { error: 'Authentication error' }, status: :unauthorized
    end
  end

  private

  def auth_token
    @auth_token ||= AuthenticateUser.new(
      params[:email],
      params[:password]
    ).call
  end
end
