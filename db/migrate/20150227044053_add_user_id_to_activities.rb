class AddUserIdToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :user_id, :integer
  end
end
