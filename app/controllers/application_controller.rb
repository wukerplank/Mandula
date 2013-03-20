class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :get_user_from_token
  
  def get_user_from_token
    return if cookies['AUTH_TOKEN'].blank?
    @current_user = User.find_by_auth_token(cookies['AUTH_TOKEN'])
  end
  
  def current_user
    @current_user
  end
  helper_method :current_user
  
  def user_required
    redirect_to '/#/signup' unless current_user
  end
  
end
