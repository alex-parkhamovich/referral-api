# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create User', type: :request do
  describe '#create' do
    context 'when User params valid' do
      it 'returns 200' do
        user = User.new(email: 'test@email.com', password: 'password')

        post sign_up_path, params: {
          email: user.email,
          password: user.password
        }

        expect(response.status).to eq(201)
      end

      it 'returns Users data' do
        user = User.new(email: 'test@email.com', password: 'password')

        post sign_up_path, params: {
          email: user.email,
          password: user.password
        }

        parsed_response = JSON.parse(response.body).deep_symbolize_keys

        expect(parsed_response.dig(:email)).to eq(user.email)
      end

      context 'when referrer exists' do
        it 'calls Credits::Processor service' do
          referrer = create(:user)

          user = User.new(
            email: 'test@email.com',
            password: 'password'
          )

          expect_any_instance_of(::Credits::Processor).to receive(:run)

          post sign_up_path, params: {
            email: user.email,
            password: user.password,
            referred_by: referrer.referral_code
          }
        end
      end
    end

    context 'when User params invalid' do
      it 'returns 400' do
        user = create(:user)

        post sign_up_path, params: {
          email: user.email,
          password: user.password
        }

        expect(response.status).to eq(400)
      end

      it 'returns validation error' do
        user = create(:user)

        expected_response = {
          errors: {
            email: ['has already been taken']
          }
        }

        post sign_up_path, params: {
          email: user.email,
          password: user.password
        }

        parsed_response = JSON.parse(response.body).deep_symbolize_keys

        expect(parsed_response).to eq(expected_response)
      end

      context 'when referrer exists' do
        it 'do not call Credits::Processor' do
          user = create(:user)
          referrer = create(:user)

          expect_any_instance_of(::Credits::Processor).not_to receive(:run)

          post sign_up_path, params: {
            email: user.email,
            password: user.password,
            referred_by: referrer.referral_code
          }
        end
      end
    end
  end
end
