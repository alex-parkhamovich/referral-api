class RegistrationsController < ApplicationController
 skip_before_action :authenticate_request

  def create
    if user.valid?
      # process_credits if user.referrer_id

      render json: user
    else
      render json: { errors: user.errors }
    end
  end

  private

  def sign_up_params
    params.permit(:email, :password, :referrer_id)
  end

  def user
    @user ||= User.create!(sign_up_params)
  end

  def process_credits
    Credits::Processor.new(new_user: user)
  end
end
