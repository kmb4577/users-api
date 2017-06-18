##
# Receives the users token from the authorization headers
# and attempts to decode it to return a valid user object.
#
# Returns a user when the request headers are valid,
# otherwise raises an error.
class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  ##
  # Returns valid user object
  def call
    {
        user: user
    }
  end

  private

  attr_reader :headers

  ##
  # If the user is found in the database then
  # set the user, otherwise raise an error.
  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
  rescue ActiveRecord::RecordNotFound => e
    # raise custom error
    raise(
        ExceptionHandler::InvalidToken,
        ("#{Message.invalid_token} #{e.message}")
    )
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  ##
  # Checks for the auth token in `Authorization` header
  # and raises an exception if the token is missing.
  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    end
    raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end