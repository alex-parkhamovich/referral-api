# frozen_string_literal: true

module Users
  class Responder
    def initialize(user:)
      self.user = user
    end

    def run
      responder_attributes
    end

    private

    attr_accessor :user

    def responder_attributes
      {
        email: user.email,
        referral_link: referral_link
      }
    end

    def referral_link
      "localhost:3000/sign_up?referred_by=#{user.referral_code}"
    end
  end
end
