class Page
  require 'mandrill'
  # Extract weather information from forecast.io
  def self.check_weather(lat, long, location, name)
    @forecast = ForecastIO.forecast(lat, long)      
  
    # Begin construct of email message
    message = "Hi #{name}, just letting you know about some significant temperature changes this week in #{location}. Make sure that you adjust your insulin dosage in line with your doctor's recommendations. \n"
    # Compare weather forecast for adjacent dates
    6.times do |i|

      maxTempToday = @forecast["daily"]["data"][(i-1)]["temperatureMax"]
      maxTempMorrow = @forecast["daily"]["data"][i]["temperatureMax"]
      minTempToday = @forecast["daily"]["data"][(i-1)]["temperatureMin"]
      minTempMorrow = @forecast["daily"]["data"][i]["temperatureMin"]
      time = @forecast['daily']['data'][i]['time']
      day = Time.at(time).strftime('%A')

      # Check for temperature changes greater than 5 degrees
      if ( maxTempToday - maxTempMorrow ) > 5
        difference = (maxTempToday - maxTempMorrow).round(0).abs
        message += "\n On #{day}, the maximum temperature is forecast to decrease by #{difference} degrees. "
      elsif ( maxTempMorrow - maxTempToday ) > 5
        difference = (maxTempMorrow - maxTempToday).round(0).abs
        message += "\n On #{day}, the maximum temperature is forecast to increase by #{difference} degrees. "
      end
      if ( minTempToday - minTempMorrow ) > 5
        difference = (minTempToday - minTempMorrow).round(0).abs
        message += "\n On #{day}, the minimum temperature is forecast to decrease by #{difference} degrees. "
      elsif ( minTempMorrow - minTempToday ) > 5
        difference = (minTempMorrow - minTempToday).round(0).abs
        message += "\n On #{day}, the minimum temperature is forecast to increase by #{difference} degrees. "
      end
    end
    message + "\n\n - The Glucosy Team"
  end

  # Utilise Mandrill to send automated weather updates
  def self.notification(message, email, name)
    m = Mandrill::API.new
      text = {
      :subject=> "Weather Update",
      :from_name=> "Glucosy",
      :text=> "#{message}",
      :to=>[
      {
      :email=> "#{email}",
      :name=> "#{name}"
      }
      ],
      :from_email=>"alerts@glucosy.com"
      }
      sending = m.messages.send text
  end
end




