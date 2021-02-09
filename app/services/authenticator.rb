# frozen_string_literal: true

class Authenticator
  def initialize(email:, password:)
    self.email = email
    self.password = password
  end

  def call
    return unless user
    return unless authenticate_user

    JsonWebToken.encode(user_id: user.id)
  end

  private

  attr_accessor :email, :password

  def authenticate_user
    user.authenticate(password)
  end

  def user
    @user ||= User.find_by_email(email)
  end
end
