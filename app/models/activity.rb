# == Schema Information
#
# Table name: activities
#
#  id            :integer          not null, primary key
#  activityname  :string
#  duration      :float
#  intensity     :integer
#  activity_time :datetime
#  created_at    :datetime
#  updated_at    :datetime
#  user_id       :integer
#  activity_date :datetime
#

class Activity < ActiveRecord::Base
  belongs_to :user
end
