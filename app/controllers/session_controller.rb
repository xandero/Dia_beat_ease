class SessionController < ApplicationController

  before_action :check_if_logged_in, :only => [:index]

  def new
  end

  def create
    @user = User.find_by :username => params[:username]
    if @user.present? && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to '/dashboard'
    else
        redirect_to new_user_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
  
  private
  def check_if_logged_in
    redirect_to(root_path) unless @current_user.present?
  end

end