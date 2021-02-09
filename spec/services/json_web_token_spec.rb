# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JsonWebToken do
  describe '#encode' do
    let(:user) { create(:user) }

    it 'returns encoded JWT token' do
      response = described_class.encode(user_id: user.id)

      expect(response).not_to eq(nil)
    end
  end

  describe '#decode' do
    let(:user) { create(:user) }

    context 'when token valid' do
      it 'returns decoded Hash token' do
        valid_token = described_class.encode(user_id: user.id)

        response = described_class.decode(valid_token)

        expect(response).not_to eq(nil)
      end
    end

    context 'when token invalid' do
      it 'returns nil' do
        response = described_class.decode('')

        expect(response).to eq(nil)
      end
    end
  end
end
