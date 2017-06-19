class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  # authorize_request is called before each action on all controllers,
  # except for the application_controller#authorize (called when logging in a user),
  # and the Users#signup method when a user is signing up for a new user account.
  before_action :authorize_request
  attr_reader :current_user

  private

  ##
  #
  # Callback that authenticates every request except for 'application_controller#authentication'
  # and 'users_controller#signup'.
  #
  # If the request token is valid then returns a user.
  #
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end
