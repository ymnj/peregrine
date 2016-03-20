class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def user_signed_in?
    session[:user_id].present?
  end

  def current_user
    @user ||= User.find(session[:user_id]) if user_signed_in?
  end

  def user_sign_in(user)
    session[:user_id] = user.id
  end


  helper_method :user_signed_in?
  
end
