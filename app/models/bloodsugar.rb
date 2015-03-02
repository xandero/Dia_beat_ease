# == Schema Information
#
# Table name: bloodsugars
#
#  id          :integer          not null, primary key
#  bslevel     :float
#  readingtime :datetime
#  mealtime    :string
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#
require 'pry'
class Bloodsugar < ActiveRecord::Base
  belongs_to :user

  def self.import(file)

    # CSV is part of rails
    # parsing (read:splitting) our single column into individual columns
    CSV.parse(file.tempfile, :col_sep => ";", :headers => true) do |row|
    # Bloodsugar.create! new row and << csv data to database
    # binding.pry
    # Date and time adds to our DB but undefined method for '+'
    Bloodsugar.create!(readingtime: (row['Date'] + 'T' + row['Time']), bslevel: row['Result'])
    end

  end

end
