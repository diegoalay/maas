class ApplicationController < ActionController::Base
  def respond_with_successful(data = nil)
    response_body = { successful: true }
    response_body[:data] = data
    render status: :ok, json: response_body.to_json
  end

  def respond_with_error(message = '', details = [])
    render status: :ok, json: {
      successful: false,
      error: { message: message, details: details }
    }.to_json
  end

  def respond_with_not_found
    render status: :not_found, json: {
      successful: false,
      error: { message: 'Not found', details: [] }
    }.to_json
  end
end
