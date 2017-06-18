#TODO REFACTOR WHOLE FILE


# The AuthenticateUser service accepts a user username and password, checks if they are valid and then creates a token with the user id as the payload.
class AuthenticateUser
  def initialize(username, password)
    @username = username
    @password = password
  end

  # Service entry point
  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_reader :username, :password

  # verify user credentials
  def user
    user = User.find_by(username: username)
    return user if user && user.authenticate(password)
    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end