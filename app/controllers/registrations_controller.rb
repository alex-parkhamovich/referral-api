class RegistrationsController < ApplicationController
 skip_before_action :authenticate_request

  def create
    if user.valid?
      render json: user
    else
      render json: { errors: user.errors }
    end
  end

  private

  def sign_up_params
    params.permit(:email, :password, :password_confirmation)
  end

  def user
    @user ||= User.create(sign_up_params)
  end
end
