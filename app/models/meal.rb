# == Schema Information
#
# Table name: meals
#
#  id         :integer          not null, primary key
#  meal_time  :datetime
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Meal < ActiveRecord::Base
  belongs_to :user
  has_many :foods
end
