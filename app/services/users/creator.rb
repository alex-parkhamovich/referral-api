# frozen_string_literal: true

module Users
  class Creator
    def initialize(params:)
      self.params = params
    end

    def create
      user.update_attributes(referrer: referrer) if referrer

      user
    end

    private

    attr_accessor :params

    def referrer
      @referrer ||= User.find_by(referral_code: params[:referred_by])
    end

    def user
      @user ||= User.create!(
        email: params[:email],
        password: params[:password]
      )
    end
  end
end
