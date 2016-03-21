class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if new_password_is_different?
      if @user.save
        user_sign_in(@user)
        redirect_to root_path, notice: "Signed up"
      else
        render :new
      end
    else 
      flash[:alert] = "Please re-check your information"
      render :edit
    end
  end

  def edit
    @user = User.find(current_user)
  end

  def update
    @user = User.find(current_user)

    if @user.update user_params
      redirect_to root_path, notice: "Information updated!"
    else
      render :edit
    end

  end



  private

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :password, :password_confirmation, :avatar)
  end


end
