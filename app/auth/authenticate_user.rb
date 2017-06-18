##
# If the username and password are valid then a jwt token will be created for
# the user's preceeding api requests. Note the token will expire 24 hours
# after it is created for the current session.
class AuthenticateUser
  def initialize(username, password)
    @username = username
    @password = password
  end

  ##
  # Authentication for each request is verified with the
  # users session token and their payload (user_id)
  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_reader :username, :password

  ##
  # Verifies the current user's credentials.
  #
  def user
    user = User.find_by(username: username)
    return user if user && user.authenticate(password)
    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end