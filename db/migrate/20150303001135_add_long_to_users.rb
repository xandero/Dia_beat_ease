class AddLongToUsers < ActiveRecord::Migration
  def change
    add_column :users, :long, :string
  end
end
