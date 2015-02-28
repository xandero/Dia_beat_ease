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
#

class User < ActiveRecord::Base
  has_many :meals
  has_many :activities
  has_many :bloodsugars

  has_secure_password

  validates :username, :uniqueness => true, :presence => true
  validates :email, :uniqueness => true, :presence => true
end

def calculate_stats
  daily_insulin = 0.55 * @user.weight
  @user.basal_insulin = daily_insulin * 0.5 # usually 40-50% depending on individual
  @user.bolus_insulin = @user.bolus_insulin.to_f
# !! need to add target BS level to user model >> @bloodsugar.target
  carb_coverage_ratio = 500 / daily_insulin #1 unit of insulin will counteract this many carbs
end
