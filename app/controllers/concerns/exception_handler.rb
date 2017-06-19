module ExceptionHandler
  extend ActiveSupport::Concern

  # Define StandardError subclasses so that a
  # rescue will catch any of the following custom errors.
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end

  included do
    # Define responces that will be retured from each of the
    # custom classes defined above.
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::ExpiredSignature, with: :four_twenty_two


    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
  end


  private

  ##
  # Returns a JSON responce with a 422 status code indicating an unprocessable entity.
  def four_twenty_two(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end

  ##
  # Returns a JSON responce with a 401 status code indicating an Unauthorized request.
  def unauthorized_request(e)
    json_response({ message: e.message }, :unauthorized)
  end
end