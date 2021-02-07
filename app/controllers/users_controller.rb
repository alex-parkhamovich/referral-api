# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: :create

  def index
    render json: current_user
  end

  def create
    if user.valid?
      Credits::Processor.new(new_user: user).run if user.referrer

      render json: user
    else
      render json: { errors: user.errors }
    end
  end

  private

  def sign_up_params
    params.permit(:email, :password, :referred_by)
  end

  def user
    @user ||= Users::Creator.new(params: sign_up_params).create
  end
end
