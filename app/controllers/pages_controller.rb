class PagesController < ApplicationController
  def landing
  end

  def about
  end

  def check_weather(lat, long)
    @forecast = ForecastIO.forecast(lat, long)

    6.times do |i|
      maxTempToday = @forecast["daily"]["data"][(i-1)]["temperatureMax"]
      maxTempMorrow = @forecast["daily"]["data"][i]["temperatureMax"]
      minTempToday = @forecast["daily"]["data"][(i-1)]["temperatureMin"]
      minTempMorrow = @forecast["daily"]["data"][i]["temperatureMin"]
      if ( maxTempToday - maxTempMorrow ) > 5
        print 'Just letting you know that the maximum temperature over the bext few days is forecast to decrease by more than 10 degrees! Be sure to adjust your insulin dosage in line with the recommendations from your doctor.'
      elsif ( maxTempMorrow - maxTempToday ) > 5
        print 'Just letting you know that the maximum temperature over the bext few days is forecast to increase by more than 10 degrees! Be sure to adjust your insulin dosage in line with the recommendations from your doctor.'
      end
      if ( minTempToday - minTempMorrow ) > 5
        print 'Just letting you know that the minimum temperature over the bext few days is forecast to decrease by more than 10 degrees! Be sure to adjust your insulin dosage in line with the recommendations from your doctor.'
      elsif ( maxTempMorrow - maxTempToday ) > 5
        print 'Just letting you know that the minimum temperature over the bext few days is forecast to increase by more than 10 degrees! Be sure to adjust your insulin dosage in line with the recommendations from your doctor.'
      end
    end
  end

  def testing
    @user = User.find_by :id => session[:user_id]    
    @ip_address = request.remote_ip
    @list = Geocoder.search @ip_address
    @city = @list.first.city
    @user.update(:lat => @list[0].latitude, :long => @list[0].longitude)

    @weather = check_weather(41.9000, 12.5000)
    # binding.pry
  end

  def calc
  end
end
