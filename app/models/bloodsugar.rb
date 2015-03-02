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
    binding.pry
      if row['Date'] && row['Time']
        # if we have this blood reading at this date, don't create this entry 
        Bloodsugar.create!(readingtime: (row['Date'] + 'T' + row['Time']), bslevel: row['Result'] )
        # Bloodsugar.create!(readingtime: (row['Date'] + 'T' + row['Time']), bslevel: row['Result'], user_id: @user.id )
      end
    end

  end

end
