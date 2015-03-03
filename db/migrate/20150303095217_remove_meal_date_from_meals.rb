class RemoveMealDateFromMeals < ActiveRecord::Migration
  def change
    remove_column :meals, :meal_date, :datetime
  end
end
