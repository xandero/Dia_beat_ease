class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create user_params
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :dob, :gender, :weight, :height, :basal_insulin, :bolus_insulin, :diabetes_type, :password, :password_confirmation)
  end
end
