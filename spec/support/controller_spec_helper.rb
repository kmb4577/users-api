#TODO refactor whole file
module ControllerSpecHelper
  # generate tokens from user id
  # generate test token
  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  # generate expired tokens from user id
  # generate expired token
  def expired_token_generator(user_id)
    JsonWebToken.encode({ user_id: user_id }, (Time.now.to_i - 10))
  end

  # return valid headers
  def valid_headers
    {
        "Authorization" => token_generator(user.id),
        "Content-Type" => "application/json"
    }
  end

  # return invalid headers
  def invalid_headers
    {
        "Authorization" => nil,
        "Content-Type" => "application/json"
    }
  end
end