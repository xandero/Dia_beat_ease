class UsersController < ApplicationController
  require 'mandrill'
  before_action :check_if_logged_in, :only => [:index]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create user_params
    if @user.save
      # logs user in automatically upon signup
      session[:user_id] = @user.id
      redirect_to edit_user_path(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find params[:id]   
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    user = User.find params[:id]
    user.update user_params
    redirect_to user_path
  end

  def destroy
    user = User.find params[:id]
    user.destroy
    redirect_to users_path
  end

  def dashboard
    @user = User.find_by :id => session[:user_id]    
    @ip_address = request.remote_ip
    @list = Geocoder.search @ip_address
    @city = @list.first.city
    @user.update(:lat => @list[0].latitude, :long => @list[0].longitude, :location => @city)  
  end

  def readingtime
    readingtimes = Bloodsugar.pluck :readingtime
    render :json => readingtimes
  end

  def bslevel
    bslevels = Bloodsugar.pluck :bslevel
    render :json => bslevels
  end

  def bslevel_lastthirty
    bslevels = Bloodsugar.where(:user_id => @current_user.id).limit(30).pluck(:bslevel).reverse 
    render :json => bslevels
  end

  def readingtime_lastthirty
    readingtimeStrf = []
    readingtimes = Bloodsugar.where(:user_id => @current_user.id).limit(30).pluck(:readingtime).reverse
      readingtimes.each do |readingtime|
        readingtimeStrf << readingtime.strftime("%R, %d/%m")
      end
    render :json => readingtimeStrf
  end


  private
  def user_params
    params.require(:user).permit(:username, :email, :dob, :gender, :weight, :height, :basal_insulin, :bolus_insulin, :diabetes_type, :password, :password_confirmation)
  end

  def check_if_logged_in
    redirect_to(root_path) unless @current_user.present?
  end

end
