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


# RSPEC

# MODEL
# + user model

# CONTROLLER
# + sessions_controller
# + users_controller

# SERVICES
# + credits::processor service
# + users::creator service
# + users::responder service
# + authenticator service
# + authorizer service






# + An existing user can create a referral to invite people, via a shareable sign-up link that contains a unique code

# + When 5 people sign up using that referral, the inviter gets $10.

# + When somebody signs up referencing a referral, that person gets $10 on signup.
# Signups that do not reference referrals do not get any credit.

# + Multiple inviters may invite the same person. Only one inviter can earn credit for a
# particular user signup. An inviter only gets credit when somebody they invited signs up; they do not get credit if they invite somebody who already has an account.



# Use cases:

# + Alice, an existing user, creates a referral. She gets a link that has a unique code in it.
# She emails that link to 5 of her friends.

# + Bob, one of Alice’s friends, clicks on the link. He goes through the signup process to
# create a new account. Once he has created his account, he sees that he has $10 in
# credit.

# + Four more people follow the same process as Bob, clicking on the link Alice sent them.
# They all get $10 in credit. Once the fifth person has signed up, Alice sees that she has
# $10 in credit.

# + Jeffrey signs up using a link that does not contain a unique referral code. After he
# creates a new account, he has $0 in credit.



# Evaluation

# ● Does it have the features to fulfill the requirements and use cases?
# ● Is the code readable and self-documenting?
# ● Are there automated tests that validate the functionality works as intended?
# ● Is the solution simple and well organized?
# ● Is your code error-resistant and does it consider reasonable edge-cases?
# ● Would the API allow a capable front-end developer to build an application?



# TODO:
# DEVELOPMENT:
# + UNIQ CODE instead of USER_ID
# + USERS index PAGE WITH uniq code
# + RSPEC ALL STUFF instead of AUTH services
# + REFACTORING AUTH STUFF
# 5) RSPEC AUTH STUFF
# 6) CHANGE localohost:3000 to APPLICATION_HOST (add application.yml)
# 7) users#index spec + responder + responder spec

# DEPLOY:
# 1) push Git
# 2) push Heroku
# 3) Documentation for FE
# 4) README
