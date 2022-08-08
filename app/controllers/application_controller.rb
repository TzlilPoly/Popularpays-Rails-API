class ApplicationController < ActionController::API
  before_action :restrict_access

  def restrict_access
    apiKey = request.headers['apiKey']
    @api_key = ApiKey.find_by(key: apiKey)
    if !@api_key
      render json: {error: "Api Authorization failed"}, status: :network_authentication_required
    end
  end
end
