class Notifier < ApplicationMailer
  default from: 'notify@diabetease.com'

  def weather_alert(user)
    @user = user
    @url = 'http://example.com/login'
    mail(to: @user.email, subject: 'The weather is about to change!')
  end

end
