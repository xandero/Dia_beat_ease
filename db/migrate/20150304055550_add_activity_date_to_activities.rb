class AddActivityDateToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :activity_date, :datetime
  end
end
