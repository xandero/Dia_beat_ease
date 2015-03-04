class Page
  require 'mandrill'
  def self.check_weather(lat, long, location, name)
    @forecast = ForecastIO.forecast(lat, long)      
    
    message = "Hi #{name}, just letting you know about some significant temperature changes this week in #{location}. Make sure that you adjust your insulin dosage in line with your doctor's recommendations. \n"
    6.times do |i|

      maxTempToday = @forecast["daily"]["data"][(i-1)]["temperatureMax"]
      maxTempMorrow = @forecast["daily"]["data"][i]["temperatureMax"]
      minTempToday = @forecast["daily"]["data"][(i-1)]["temperatureMin"]
      minTempMorrow = @forecast["daily"]["data"][i]["temperatureMin"]
      time = @forecast['daily']['data'][i]['time']
      day = Time.at(time).strftime('%A')

      if ( maxTempToday - maxTempMorrow ) > 2
        difference = (maxTempToday - maxTempMorrow).round(0).abs
        message += "\n On #{day}, the maximum temperature is forecast to decrease by #{difference} degrees. "
      elsif ( maxTempMorrow - maxTempToday ) > 2
        difference = (maxTempMorrow - maxTempToday).round(0).abs
        message += "\n On #{day}, the maximum temperature is forecast to increase by #{difference} degrees. "
      end
      if ( minTempToday - minTempMorrow ) > 2
        difference = (minTempToday - minTempMorrow).round(0).abs
        message += "\n On #{day}, the minimum temperature is forecast to decrease by #{difference} degrees. "
      elsif ( minTempMorrow - minTempToday ) > 2
        difference = (minTempMorrow - minTempToday).round(0).abs
        message += "\n On #{day}, the minimum temperature is forecast to increase by #{difference} degrees. "
      end
    end
    message + "\n\n - The Diabet-ease Team"
  end

  def self.notification(message, email, name)

    m = Mandrill::API.new
      text = {
      :subject=> "Weather Update",
      :from_name=> "Diabet-ease",
      :text=> "#{message}",
      :to=>[
      {
      :email=> "#{email}",
      :name=> "#{name}"
      }
      ],
      :from_email=>"alerts@diabetease.com"
      }
      sending = m.messages.send text
  end
end




