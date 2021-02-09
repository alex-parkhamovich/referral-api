# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Creator do
  describe '#create' do
    context 'when User params valid' do
      it 'creates User' do
        creator = described_class.new(params: valid_params)

        expect { creator.create }.to change { User.count }.by(1)
      end

      context 'when Referrer exists' do
        it 'assigns referrer to new User' do
          referrer = create(:user)
          referrer_params = { referred_by: referrer.referral_code }

          creator = described_class.new(
            params: valid_params.merge(referrer_params)
          )

          expect { creator.create }.to change { User.last.referrer_id }
            .from(nil).to(referrer.id)
        end
      end

      context 'when Referrer does not exist' do
        it 'does not assign referrer to new User' do
          referrer = create(:user)

          creator = described_class.new(params: valid_params)

          expect { creator.create }.not_to change { User.last.referrer_id }
        end
      end
    end

    context 'when User params invalid' do
      it 'does not create new User' do
        creator = described_class.new(params: invalid_params)

        expect { creator.create }.not_to change { User.count }
      end
    end
  end

  private

  def valid_params
    {
      email: 'email@gmail.com',
      password: 'password'
    }
  end

  def invalid_params
    {
      email: '',
      password: 'password'
    }
  end
end
