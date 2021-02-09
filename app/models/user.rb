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

# TODO:
# DEVELOPMENT:
# + UNIQ CODE instead of USER_ID
# + USERS index PAGE WITH uniq code
# + RSPEC ALL STUFF instead of AUTH services
# + REFACTORING AUTH STUFF
# + RSPEC AUTH STUFF
# 6) CHANGE localohost:3000 to APPLICATION_HOST (add application.yml)
# 7) users#index spec + responder + responder spec (localhost:3000)

# DEPLOY:
# 1) push Git
# 2) push Heroku
# 3) Documentation for FE
# 4) README
