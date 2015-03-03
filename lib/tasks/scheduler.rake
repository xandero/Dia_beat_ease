desc "Daily weather check"
task :weather_forecast => :environment do
  puts "Weather forecast"
  
    User.all.each do |i|
      location = i.location
      latitude = i.lat
      longitude = i.long
      name = i.username
      email = i.email
      message = Page.check_weather(latitude, longitude, location, name)

      Page.notification(message, email, name)
    end
end
