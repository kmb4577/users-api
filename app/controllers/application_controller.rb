require 'devise'
# require 'bcrypt'

class ApplicationController < ActionController::API
  # #TODO:  before_action :authenticate_req
  include Response
  include ExceptionHandler

  # #TODO:  called before every action on controllers
  before_action :authorize_request
  attr_reader :current_user

  private

  # #TODO: Checks for a valid request token and return user
  #
  # Callback that authenticates every request except for 'authentication'
  #
  # #TODO: If the request is authorized, it will set the current user object to be used in the other controllers
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end
