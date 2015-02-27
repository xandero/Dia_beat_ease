class AddUserIdToBloodsugars < ActiveRecord::Migration
  def change
    add_column :bloodsugars, :user_id, :integer
  end
end
