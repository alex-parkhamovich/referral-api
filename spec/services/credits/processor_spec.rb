# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Credits::Processor do
  NEW_REFERRAL_BONUS_POINT_MINUS_CREDITS_POINTS = -4

  describe '#run' do
    let(:user) { create(:user) }
    let(:referrer) { create(:user) }

    before(:each) { user.update_attributes(referrer: referrer) }

    it 'adds bonus credits to new_user' do
      processor = described_class.new(new_user: user)

      expect { processor.run }.to change { user.reload.credits }
        .by(described_class::BONUS_CREDITS_AMOUNT)
    end

    it 'adds referral_points to referrer' do
      processor = described_class.new(new_user: user)

      expect { processor.run }.to change { referrer.reload.referral_points }
        .by(described_class::BONUS_POINTS_AMOUNT)
    end

    context 'when referrer have enough referral_points' do
      before(:each) { referrer.update_attributes(
          referral_points: described_class::POINTS_AMOUNT_FOR_BONUS_CREDITS
      )}

      it 'decrements bonus points from refferers points amount' do
        processor = described_class.new(new_user: user)

        expect { processor.run }.to change { referrer.reload.referral_points }
          .by(NEW_REFERRAL_BONUS_POINT_MINUS_CREDITS_POINTS)
      end

      it 'adds bonus credits to referrer' do
        processor = described_class.new(new_user: user)

        expect { processor.run }.to change { referrer.reload.credits }
          .by(described_class::BONUS_CREDITS_AMOUNT)
      end
    end

    context 'when referrer have not enough referral_points' do
      it 'does not add bonus credits to referrer' do
        processor = described_class.new(new_user: user)

        expect { processor.run }.not_to change { referrer.reload.credits }
      end
    end
  end
end
