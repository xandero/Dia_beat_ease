# == Schema Information
#
# Table name: foods
#
#  id                  :integer          not null, primary key
#  foodname            :string
#  quantity            :float
#  serving_size_qty    :float
#  serving_size_unit   :string
#  carbs               :float
#  serving_size_weight :float
#  insulin_required    :float
#  consumed_at         :datetime
#  created_at          :datetime
#  updated_at          :datetime
#  meal_id             :integer
#

class Food < ActiveRecord::Base
  belongs_to :meal
end
