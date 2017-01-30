class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      username == ENV["ADMIN_USERNAME"] &&
      password == ENV["ADMIN_PASSWORD"]
    end
  end
end
