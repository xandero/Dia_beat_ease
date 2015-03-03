desc "Daily weather check"
task :update_feed => :environment do
  puts "Updating feed..."

  
    User.all.each do |i|
      latitude = i.lat
      longitude = i.long
      Page.check_weather(latitude, longitude)

    end


end

task :send_reminders => :environment do
  User.send_reminders
end