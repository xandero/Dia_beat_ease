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

class Bloodsugar < ActiveRecord::Base
  belongs_to :user

end
