class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  class UnauthorizedException < Exception; end

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  skip_before_filter :verify_authenticity_token

  def after_sign_out_path_for(resource)
    '/'
  end

  def after_sign_in_path_for(resource)
    session[:user_return_to] || root_path
  end

  def root_path
    servers_path
  end
  helper_method :root_path
end
