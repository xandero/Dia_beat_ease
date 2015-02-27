class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :activityname
      t.float :duration
      t.integer :intensity
      t.datetime :activity_time
      t.timestamps
    end
  end
end
