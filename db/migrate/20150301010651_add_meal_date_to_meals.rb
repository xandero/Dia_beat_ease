class AddMealDateToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :meal_date, :datetime
  end
end
