# frozen_string_literal: true

class Authorizer
  def initialize(headers: {})
    self.headers = headers
  end

  def call
    return unless decoded_auth_token

    authorized_user
  end

  private

  attr_accessor :headers

  def authorized_user
    @user ||= User.find_by_id(decoded_auth_token[:user_id])
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    return unless headers['Authorization'].present?
    
    headers['Authorization'].split(' ').last
  end
end
