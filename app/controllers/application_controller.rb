# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_request

  attr_reader :current_user

  private

  def authenticate_request
    render json: { error: 'Not Authorized' }, status: 401 unless current_user
  end

  def current_user
    @current_user ||= AuthorizeApiRequest.new(headers: request.headers).call
  end
end
