class Page

  def self.check_weather(lat, long)
    @forecast = ForecastIO.forecast(lat, long)

    6.times do |i|

      maxTempToday = @forecast["daily"]["data"][(i-1)]["temperatureMax"]
      maxTempMorrow = @forecast["daily"]["data"][i]["temperatureMax"]
      minTempToday = @forecast["daily"]["data"][(i-1)]["temperatureMin"]
      minTempMorrow = @forecast["daily"]["data"][i]["temperatureMin"]
      time = @forecast['daily']['data'][0]['time']
      day = Time.at(time).strftime('%A')
      puts "Hi, just letting you know about some significant temperature changes this week. Make sure that you adjust your insulin dosage in line with your doctor's recommendations."
      if ( maxTempToday - maxTempMorrow ) > 3
        print "Just letting you know that on #{day} the maximum temperature is forecast to decrease by more than 3 degrees."
      elsif ( maxTempMorrow - maxTempToday ) > 3
        print "Just letting you know that on #{day} the maximum temperature is forecast to increase by more than 3 degrees."
      end
      if ( minTempToday - minTempMorrow ) > 3
        print "Just letting you know that on #{day} the minimum temperature is forecast to decrease by more than 3 degrees."
      elsif ( maxTempMorrow - maxTempToday ) > 3
        print "Just letting you know that on #{day} the minimum temperature is forecast to increase by more than 3 degrees."
      end
    end
  end
end




