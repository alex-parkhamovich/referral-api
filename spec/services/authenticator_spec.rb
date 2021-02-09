# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Authenticator do
  describe '#call' do
    let(:user) { create(:user) }

    context 'when user exists' do
      context 'when user password authenticated' do
        it 'returns JWT token' do
          response = described_class.new(
            email: user.email,
            password: user.password
          ).call

          expect(response).not_to eq(nil)
        end
      end

      context 'when user password invalid' do
        it 'returns nil' do
          response = described_class.new(
            email: user.email,
            password: 'invalid'
          ).call

          expect(response).to eq(nil)
        end
      end
    end

    context 'when user not exists' do
      it 'returns nil' do
        response = described_class.new(
          email: 'invalid@email.com',
          password: 'invalid'
        ).call

        expect(response).to eq(nil)
      end
    end
  end
end
