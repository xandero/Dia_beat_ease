class Page

  def self.check_weather(lat, long, location)
    @forecast = ForecastIO.forecast(lat, long)
    binding.pry
    puts "Hi, just letting you know about some significant temperature changes this week in #{location}. Make sure that you adjust your insulin dosage in line with your doctor's recommendations."      
    
    6.times do |i|

      maxTempToday = @forecast["daily"]["data"][(i-1)]["temperatureMax"]
      maxTempMorrow = @forecast["daily"]["data"][i]["temperatureMax"]
      minTempToday = @forecast["daily"]["data"][(i-1)]["temperatureMin"]
      minTempMorrow = @forecast["daily"]["data"][i]["temperatureMin"]
      time = @forecast['daily']['data'][0]['time']
      day = Time.at(time).strftime('%A')

      if ( maxTempToday - maxTempMorrow ) > 3
        difference = (maxTempToday - maxTempMorrow).round(0).abs
        print "This #{day} the maximum temperature is forecast to decrease by #{difference} degrees. "
      elsif ( maxTempMorrow - maxTempToday ) > 3
        difference = (maxTempMorrow - maxTempToday).round(0).abs
        print "This #{day} the maximum temperature is forecast to increase by #{difference} degrees. "
      end
      if ( minTempToday - minTempMorrow ) > 3
        difference = (maxTempToday - maxTempMorrow).round(0).abs
        print "This #{day} the minimum temperature is forecast to decrease by #{difference} degrees. "
      elsif ( maxTempMorrow - maxTempToday ) > 3
        difference = (maxTempMorrow - maxTempToday).round(0).abs
        print "This #{day} the minimum temperature is forecast to increase by #{difference} degrees. "
      end
    end
  end
end




