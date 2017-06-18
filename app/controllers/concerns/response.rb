module Response
  ##
  # responds with JSON and an HTTP status code (200 by default).
  #
  def json_response(object, status = :ok)
    render json: object, status: status
  end
end

#TODO REMOVE
# set_todo - callback method to find a todo by id.
#     In the case where the record does not exist, ActiveRecord will
# throw an exception ActiveRecord::RecordNotFound. We'll rescue from this exception and return a 404 message.
# end