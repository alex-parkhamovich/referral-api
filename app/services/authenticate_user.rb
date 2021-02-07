# frozen_string_literal: true

class AuthenticateUser
  def initialize(email, password)
    self.email = email
    self.password = password
  end

  def call
    JsonWebToken.encode(user_id: authenticated_user.id)
  end

  private

  attr_accessor :email, :password

  def authenticated_user
    return user if user.authenticate(password)

    raise 'Invalid credentials'
  end

  def user
    @user ||= User.find_by_email(email)
  end
end
