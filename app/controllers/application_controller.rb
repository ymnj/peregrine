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

  def avatar(user)
    user.avatar.url(:small_thumb) || "default-avatar.png"
  end

  def user_full_name
    "#{current_user.first_name} #{current_user.last_name}"
  end

  helper_method :user_signed_in?
  helper_method :current_user
  helper_method :avatar
  helper_method :user_full_name
  
end
