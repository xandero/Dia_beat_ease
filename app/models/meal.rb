# == Schema Information
#
# Table name: meals
#
#  id          :integer          not null, primary key
#  meal_time   :datetime
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  total_carbs :float
#  meal_date   :datetime
#

class Meal < ActiveRecord::Base
  belongs_to :user
  has_many :foods
end

def calculate_total_carbs
  meal.total_carbs = @meal.foods.sum(:carbs).round(1)
end

def calculate_insulin
  
  @target_bs = 6.5

  # amount of insulin required to offset carbs in meal
  reqd_insulin_dose = meal.total_carbs / user.bolus_insulin  
end

# we should add some comments or guidance in faqs regarding how these calculations are performed.

# amount of insulin required to correct discrepancy between actual and target BS level
# bs_correction = (@bloodsugar.target - @bloodsugar.bslevel) / @user.bolus_insulin # is this the bolus insulin level? 
# total required insulin accounting for current BS and carbs that will shortly be consumed.
# reqd_insulin_dose = meal_carb_coverage + bs_correction
