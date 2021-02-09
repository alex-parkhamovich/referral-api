# frozen_string_literal: true

class User < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  has_secure_password
  has_secure_token :referral_code

  validates :email,
    presence: true,
    length: { maximum: 50 },
    format: { with: EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { maximum: 50 }

  belongs_to :referrer, class_name: 'User', optional: true
end

# DEPLOY:
# + push Git
# + REFACTOR JWT LIB
# 2) push Heroku
# 3) Documentation for FE
# 4) README
# 5) CLEANUP CODEBASE
# 6) last tests before sending


# LAST TEST FLOW
# - sign_up without referral_code (check if no credits, user returned)
# - sign_in with new user (auth_token returned)
# - users page with auth token (user params returned)
# - sign up with referral_code link (new user with credits, referral_point increased)
# - sign_up 4 more users (new users with credits, referral_ppoint increased)
# - sign_up 5th user (new user with credits, referral_points decreased, credits increased)
