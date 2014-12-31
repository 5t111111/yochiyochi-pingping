class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  http_basic_authenticate_with :name => ENV['BASIC_AUTH_USERNAME'], :password => ENV['BASIC_AUTH_PASSWORD'] if Rails.env == "staging"

  private

  # Confirms a logged-in user.
  def logged_in_user
    return true if logged_in?
    flash[:danger] = 'ログインが必要です'
    redirect_to root_url
  end
end
