class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :foodname
      t.float :quantity
      t.float :serving_size_qty
      t.string :serving_size_unit
      t.float :carbs
      t.float :serving_size_weight
      t.float :insulin_required
      t.datetime :consumed_at
      t.timestamps
    end
  end
end
