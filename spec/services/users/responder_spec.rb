# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Responder do
  describe '#run' do
    let(:user) { create(:user) }

    it 'responds with email and referral_link' do
      expected_response = {
        email: user.email,
        referral_link: referral_link
      }

      response = described_class.new(user: user).run

      expect(response).to eq(expected_response)
    end
  end

  private

  def referral_link
    "localhost:3000/sign_up?referred_by=#{user.referral_code}"
  end
end
