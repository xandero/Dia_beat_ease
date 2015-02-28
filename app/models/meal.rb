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

def calculate_insulin
# !! add total carb field to meals model.
  @totalcarbs = @meal.foods.sum(:carbs).round(1)
  # amount of insulin required to offset carbs in meal
  meal_carb_coverage = @totalcarbs / @user.bolus_insulin
  # amount of sinsulin required to correct discrepancy between actual and target BS level
  bs_correction = (@bloodsugar.target - @bloodsugar.bslevel) / @user.bolus_insulin # is this the bolus insulin level? 
  # total required insulin accunting for current BS and carbs that will shortly be consumed.
  reqd_insulin_dose = meal_carb_coverage + bs_correction

# we should add some comments or guidance in faqs regarding how these calculations are performed.

end
