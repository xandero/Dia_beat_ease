class CreateBloodsugars < ActiveRecord::Migration
  def change
    create_table :bloodsugars do |t|
      t.float :bslevel
      t.datetime :readingtime
      t.string :mealtime
      t.timestamps
    end
  end
end
