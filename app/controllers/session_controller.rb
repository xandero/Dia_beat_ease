class SessionController < ApplicationController
  def new
    redirect_to '/testing'
  end

  def create
    @user = User.find_by :username =>params[:username]
    if @user.present? && @user.authenticate(params[:password])
        session[:user_id] = @user.id

        # just put in for testing purposes, default page after login can be decided later
        redirect_to '/testing'
        #redirect_to(user_path(@user))
    else
        flash[:error] = "Invalid login or password"
        redirect_to(login_path)
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
