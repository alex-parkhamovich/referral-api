# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Access Users page', type: :request do
  describe '#index' do
    let(:user) { create(:user) }

    context 'when User authenticated' do
      it 'returns 200' do
        stub_authorization

        get users_path, headers: json_headers

        expect(response.status).to eq(200)
      end

      it 'returns Users referral_link' do
        expected_response = {
          email: user.email,
          credist: user.credits,
          referral_points: user.referral_points,
          referral_link: referral_link
        }

        stub_authorization

        get users_path, headers: json_headers

        parsed_response = JSON.parse(response.body).deep_symbolize_keys

        expect(parsed_response).to eq(expected_response)
      end
    end

    context 'when User not authenticated' do
      it 'returns 401' do
        get users_path, headers: { 'Authorization' => 'invalid' }

        expect(response.status).to eq(401)
      end
    end
  end

  private

  def referral_link
    ENV.fetch('HOST') + "/sign_up?referred_by=#{user.referral_code}"
  end

  def stub_authorization
    post sign_in_path, params: { email: user.email, password: user.password }
  end

  def auth_token
    @auth_token ||= JSON.parse(response.body).dig('auth_token')
  end

  def json_headers
    {
      'Accept' => 'application/vnd.api+json',
      'Content-Type' => 'application/vnd.api+json',
      'Authorization' => "Bearer #{auth_token}"
    }
  end
end
