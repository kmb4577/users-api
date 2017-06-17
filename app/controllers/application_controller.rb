require 'devise'

class ApplicationController < ActionController::API
  # before_action :authenticate_req
  include Response
  include ExceptionHandler
end
