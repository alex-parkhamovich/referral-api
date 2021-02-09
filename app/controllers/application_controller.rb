# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorize_request

  attr_reader :current_user

  private

  def authorize_request
    render json: { error: 'Not Authorized' }, status: 401 unless current_user
  end

  def current_user
    @current_user ||= Authorizer.new(headers: request.headers).call
  end
end
