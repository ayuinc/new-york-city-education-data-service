class ApplicationController < ActionController::API

  include ActionController::MimeResponds
  include ActionController::ImplicitRender

  respond_to :json

  before_filter :cors_set_access_control_headers

  private

  def cors_set_access_control_headers
    unless Rails.env.production? || Rails.env.staging?
      headers['Access-Control-Allow-Origin'] = '*'# need to be changed once it goes to production 'http://localhost:8080'
    else
      headers['Access-Control-Allow-Origin'] = 'http://localhost:8080'
    end
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = '*, X-Requested-With, X-Prototype-Version, X-CSRF-Token, Content-Type'
    headers['Access-Control-Max-Age'] = "1728000"
  end
end
