class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.date :dob
      t.string :gender
      t.float :weight
      t.float :height
      t.float :basal_insulin
      t.float :bolus_insulin
      t.string :diabetes_type
      t.boolean :is_admin, default: false
      t.timestamps
    end
  end
end
