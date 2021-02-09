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
# 1) push Git
# 2) push Heroku
# 3) Documentation for FE
# 4) README
