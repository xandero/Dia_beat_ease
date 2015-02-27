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
#

class Activity < ActiveRecord::Base

end
