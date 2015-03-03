class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate

    private
    def authenticate
        if session[:user_id].present?
            @current_user = User.find_by :id =>session[:user_id]
        end
        session[:user_id] = nil unless @current_user.present?
    end

  def notification(message)
    @user = User.find params[:id]

    m = Mandrill::API.new
      message = {
      :subject=> "Weather Alert!",
      :from_name=> "Diabetease",
      :from_email=>"alerts@diabetease.com",
      :to=>User.to_mandrill_to(User),
      :text=>"Hi #{@user.username}, " message,
      }
      sending = m.messages.send message
  end

end
