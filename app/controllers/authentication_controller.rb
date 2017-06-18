class AuthenticationController < ApplicationController
  #A user will not have an authentication token before logging in, so skip the
  # check for this when the authenticate action is called upon login
  skip_before_action :authorize_request, only: :authenticate
  #
  # returns auth token once user's login credentials are authenticated
  def authenticate
    auth_token =
        AuthenticateUser.new(auth_params[:username], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  private

  def auth_params
    params.permit(:username, :password)
  end
end
