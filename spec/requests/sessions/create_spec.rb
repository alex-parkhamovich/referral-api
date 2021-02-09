# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authenticate User', type: :request do
  describe '#create' do
    let(:user) { create(:user) }

    context 'when User params valid' do
      it 'returns 200' do 
        post sign_in_path, params: { email: user.email, password: user.password }

        expect(response.status).to eq(200)
      end

      it 'returns response with auth_token' do
        post sign_in_path, params: { email: user.email, password: user.password }

        parsed_response = JSON.parse(response.body).deep_symbolize_keys

        expect(parsed_response.dig(:auth_token)).not_to be_nil
      end
    end

    context 'when User params invalid' do
      it 'returns 401' do
        post sign_in_path, params: { email: 'wrong@email.com', password: 'invalid' }

        expect(response.status).to eq(401)
      end

      it 'does not return token' do
        post sign_in_path, params: { email: 'wrong@email.com', password: 'invalid' }

        parsed_response = JSON.parse(response.body).deep_symbolize_keys

        expect(parsed_response.dig(:auth_token)).to be_nil
      end
    end
  end
end
