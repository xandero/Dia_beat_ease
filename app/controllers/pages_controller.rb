class PagesController < ApplicationController
  def landing
    @user = User.find_by :id => session[:user_id]    
    @ip_address = request.remote_ip
    @list = Geocoder.search @ip_address
    @city = @list.first.city
    @user.update(:lat => @list[0].latitude, :long => @list[0].longitude, :location => @city)  
  end

  def about
  end

  def testing
  end

  def calc
  end
end
