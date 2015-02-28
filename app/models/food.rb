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

  # !!! This is to search for the list of foods. The fields stipulated in API request are to help the user decide which food to select.
  def search_foods
    url = "https://api.nutritionix.com/v1_1/search/#{ params[:name] }?results=0:5&fields=item_name,brand_name,item_id,brand_id,nf_serving_size_qty,nf_serving_size_unit&appId=92a57023&appKey=5a11032e7168104fdfa242bd3b62e636"
    raw_data = HTTParty.get url
    parsed_data = JSON.parse(raw_data.body)
    @food_data = parsed_data['hits']
    @meal = params[:meal_id]
  end

  # !!! In the form where user selects food, be sure to label the value of selected food as 'selected_food' as per API params request code below.
  def get_food_data
    url = "https://api.nutritionix.com/v1_1/item?id=#{ params[:selected_food] }&appId=92a57023&appKey=5a11032e7168104fdfa242bd3b62e636"
    raw_data = HTTParty.get url
    parsed_data = JSON.parse(raw_data.body)

    @food_data = parsed_data
    @meal = params[:meal_id]
  end
end

