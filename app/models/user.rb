# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string
#  dob             :date
#  gender          :string
#  weight          :float
#  height          :float
#  basal_insulin   :float
#  bolus_insulin   :float
#  diabetes_type   :string
#  is_admin        :boolean          default("false")
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string
#  email           :string
#  location        :string
#

class User < ActiveRecord::Base
  has_many :meals
  has_many :activities
  has_many :bloodsugars

  has_secure_password

  validates :username, :uniqueness => true, :presence => true
  validates :email, :uniqueness => true, :presence => true
end

def check_weather
  @forecast = ForecastIO.forecast(37.8267, -122.423)

  6.times do |i|
    maxTempToday = @forecast["daily"]["data"][(i-1)]["temperatureMax"]
    maxTempMorrow = @forecast["daily"]["data"][i]["temperatureMax"]
    if ( maxTempToday - maxTempMorrow).abs > 1
      @msg = "This will trigger a Mandrill email event!"
    else 
      "No event triggered."
    end
  end
end

def validate_bolus_level(bolus_insulin)
  if @user.bolus_insulin < 10 || @user.bolus_insulin > 30
    "Are you sure that's correct? Those figures are outside the normal range expected. Please confirm before continuing."
  end
end

def validate_basal_level(basal_insulin, weight)
  daily_insulin = 0.55 * weight
  #expected_basal_insulin = daily_insulin * 0.40
  if basal_insulin < (daily_insulin * 0.3)
    "Are you sure that is correct? That figure is below the expected range for your weight. Please confirm before continuing."
  elsif basal_insulin > (daily_insulin * 0.5)
    "Are you sure that is correct? That figure is above the expected range for your weight. Please confirm before continuing."
  end
end
