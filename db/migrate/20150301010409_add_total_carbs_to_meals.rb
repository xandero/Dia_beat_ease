class AddTotalCarbsToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :total_carbs, :float
  end
end
