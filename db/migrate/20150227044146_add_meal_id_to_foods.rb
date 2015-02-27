class AddMealIdToFoods < ActiveRecord::Migration
  def change
    add_column :foods, :meal_id, :integer
  end
end
