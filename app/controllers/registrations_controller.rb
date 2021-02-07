class RegistrationsController < ApplicationController
 skip_before_action :authenticate_request

  def create
    puts ' ' * 80
    puts "USER RETURNED IN CONTROLLER: #{user.id}"
    puts ' ' * 80

    if user.valid?
      Credits::Processor.new(new_user: user).run if user.referrer

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
    @user ||= Users::Creator.new(params: sign_up_params).create
  end
end
