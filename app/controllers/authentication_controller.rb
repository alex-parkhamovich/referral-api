class AuthenticationController < ApplicationController
 skip_before_action :authenticate_request

 def create
   auth_token = AuthenticateUser.new(params[:email], params[:password]).call

   if auth_token
     render json: { auth_token: auth_token }
   else
     render json: { error: 'Authentication error' }, status: :unauthorized
   end
 end
end
