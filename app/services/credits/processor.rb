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
      puts ' ' * 80
      puts "INIT CREDITS: #{new_user.credits}"
      puts ' ' * 80

      new_user.increment!(:credits, BONUS_CREDITS_AMOUNT) if referrer

      puts ' ' * 80
      puts "UPDATED CREDITS: #{new_user.credits}"
      puts ' ' * 80
    end

    def process_referrer
      puts ' ' * 80
      puts "INIT POINTS: #{referrer.referral_points}"
      puts ' ' * 80

      referrer.increment!(:referral_points, BONUS_POINTS_AMOUNT)

      puts ' ' * 80
      puts "UPDATED POINTS: #{referrer.referral_points}"
      puts ' ' * 80

      if referrer.referral_points >= POINTS_AMOUNT_FOR_BONUS_CREDITS
        referrer.increment!(:credits, BONUS_CREDITS_AMOUNT)
        referrer.decrement!(:referral_points, POINTS_AMOUNT_FOR_BONUS_CREDITS)
      end

      puts ' ' * 80
      puts "REFERRAL UPDATED POINTS: #{referrer.referral_points}"
      puts "REFERRAL UPDATED CREDITS: #{referrer.credits}"
      puts ' ' * 80
    end
  end
end
