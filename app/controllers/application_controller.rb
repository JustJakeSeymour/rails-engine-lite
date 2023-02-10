class ApplicationController < ActionController::API
rescue_from ActiveRecord::RecordNotFound, with: :error_response

  def error_response(error)
    render json: ErrorSerializer.error_json(error), status: 404
  end
end
