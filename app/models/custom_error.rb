# class CustomError < StandardError
#   attr_reader :status, :error, :message
#
#   def initialize(_error=nil, _status=nil, _message=nil)
#     @error = _error || 422
#     @status = _status || :unprocessable_entity
#     @message = _message || 'Something went wrong'
#   end
#
#   def respond(_error, _status, _message)
#     json = Helpers::Render.json(_error, _status, _message)
#     render json: json
#   end
# end
#
# class ApiKeyError < CustomError
#   def initialize
#     super(:unauthorized, 401, "Api Authorization failed")
#   end
# end
