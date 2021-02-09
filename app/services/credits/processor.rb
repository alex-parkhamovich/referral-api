# frozen_string_literal: true

module Credits
  class Processor
    BONUS_CREDITS_AMOUNT = 10
    BONUS_POINTS_AMOUNT = 1
    POINTS_AMOUNT_FOR_BONUS_CREDITS = 5

    def initialize(new_user:)
      self.new_user = new_user
    end

    def run
      process_new_user
      process_referrer
    end

    private

    attr_accessor :new_user

    def referrer
      @referrer ||= new_user.referrer
    end

    def process_new_user
      new_user.increment!(:credits, BONUS_CREDITS_AMOUNT) if referrer
    end

    def process_referrer
      referrer.increment!(:referral_points, BONUS_POINTS_AMOUNT)

      if referrer.referral_points >= POINTS_AMOUNT_FOR_BONUS_CREDITS
        referrer.increment!(:credits, BONUS_CREDITS_AMOUNT)
        referrer.decrement!(:referral_points, POINTS_AMOUNT_FOR_BONUS_CREDITS)
      end
    end
  end
end
