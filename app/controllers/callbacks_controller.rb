class CallbacksController < ApplicationController


  def index
    omniauth_data =   request.env['omniauth.auth']
    user          =   User.find_from_omniauth(omniauth_data)
    user          ||= User.create_from_omniauth(omniauth_data)

    if user_sign_in(user)
      redirect_to root_path, notice: "Logged in with #{omniauth_data['provider']}"
    else 
      redirect_to new_session_path
      flash[:alert] = "Something went wrong"
    end

  end


end
