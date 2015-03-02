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
  @forecast = ForecastIO.forecast(-33.8600, 151.2094)

  6.times do |i|
    maxTempToday = @forecast["daily"]["data"][(i-1)]["temperatureMax"]
    maxTempMorrow = @forecast["daily"]["data"][i]["temperatureMax"]
    minTempToday = @forecast["daily"]["data"][(i-1)]["temperatureMin"]
    minTempMorrow = @forecast["daily"]["data"][i]["temperatureMin"]   
    if ( maxTempToday - maxTempMorrow).abs > 10
      p "The max temperature will change by more than 10 degrees!"
    else 
      p "Max temperature change is less than 10 degrees."
    end
    if ( minTempToday - minTempMorrow).abs > 10
      p "The max temperature will change by more than 10 degrees!"
    else 
      p "Min temperature change is less than 10 degrees."
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
