class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      username == ENV["ADMIN_USERNAME"] &&
      password == ENV["ADMIN_PASSWORD"]
    end
  end

  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
