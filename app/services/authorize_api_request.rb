class AuthorizeApiRequest
  def initialize(headers: {})
    self.headers = headers
  end

  def call
    return unless decoded_auth_token

    authorized_user
  end

  private

  attr_reader :headers

  def authorized_user
    @user ||= User.find(decoded_auth_token[:user_id])
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      raise 'Missing token'
    end
  end
end
