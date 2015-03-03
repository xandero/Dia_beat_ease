desc "Daily weather check"
task :weather_forecast => :environment do
  puts "Weather forecast"
  
    User.all.each do |i|
      latitude = i.lat
      longitude = i.long
      Page.check_weather(latitude, longitude)
    end
end
