class User < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  has_secure_password

  validates :email,
    presence: true,
    length: { maximum: 50 },
    format: { with: EMAIL_REGEX},
    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { maximum: 50 }

  belongs_to :referrer, class_name: 'User', optional: true
end



# user invites 5 people and they signs up: +10 credits
# invited user gets +10 credits on sign up


#user referral_points default: 0
#user credits default: 0


# User
# id | email   | referred_by | referral_points | credits
#  1 | qwe@qwe |    nil      |    0            |     0
#  2 | qwe@qwe |    1        |    0            |     0


# user.new(referred_by: 1)
#


# Credits Serviec
# new_user
# new_user.referral = referral
#
# new_user.credits += 10
#
# referral.referral_points += 1
# if referral.referral_points == 5
#    referral.credits += 10
#    referral.referral_points = 0
# end
#