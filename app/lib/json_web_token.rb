# #
#
# Singleton class that provides methods for encoding/decoding user's session token.
#
# Both encode and decode class methods utilize the unique secret key in the application
# in order to sign user tokens.
class JsonWebToken
  # secret to encode and decode token
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  ##
  # Creates a users token based off of the payload param,
  # and sets a token expiration time based off of when this
  # method was called.
  #
  # Params:
  #   payload: user_id
  #   exp: (optional) Set to expire the users token after 1 day.
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    # sign token with HMAC_SECRET;rails application secret
    JWT.encode(payload, HMAC_SECRET)
  end

  ##
  # Attempts to decode the token param. If the decoding fails due to
  # obtaining an invalid token or expired token then a VerificationError
  # will be thrown to indicate this.
  #
  # Params:
  #   token: user_token (previously set from the encode class method)
  #
  def self.decode(token)
    ##TODO get payload; first index in decoded Array
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body
  rescue JWT::ExpiredSignature, JWT::VerificationError => e
    ##TODO raise custom error to be handled by custom handler
    raise ExceptionHandler::ExpiredSignature, e.message
  end
end