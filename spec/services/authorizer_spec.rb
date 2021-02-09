# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Authorizer do
  describe '#call' do
    let(:user) { create(:user) }

    context 'when auth header exists' do
      context 'when token owned user exists' do
        it 'returns authorized user' do
          auth_token = JsonWebToken.encode(user_id: user.id)

          response = described_class.new(
            headers: { 'Authorization' => auth_token }
          ).call

          expect(response).to eq(user)
        end
      end

      context 'when token owned user not found' do
        it 'returns nil' do
          auth_token = JsonWebToken.encode(user_id: user.id)
          user.delete

          response = described_class.new(
            headers: { 'Authorization' => auth_token }
          ).call

          expect(response).to eq(nil)
        end
      end
    end

    context 'when auth header not found' do
      it 'returns nil' do
        response = described_class.new.call

        expect(response).to eq(nil)
      end
    end
  end
end
