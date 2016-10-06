class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate
    secrets = YAML.load_file("config/secrets.yml")[Rails.env]

    authenticate_or_request_with_http_basic('Administration') do |username, password|
      username == secrets["auth"]["username"] &&
      password == secrets["auth"]["password"]
    end
  end
end
