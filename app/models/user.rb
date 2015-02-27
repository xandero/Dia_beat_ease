# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  username      :string
#  dob           :date
#  gender        :string
#  weight        :float
#  height        :float
#  basal_insulin :float
#  bolus_insulin :float
#  diabetes_type :string
#  is_admin      :boolean          default("false")
#  created_at    :datetime
#  updated_at    :datetime
#

class User < ActiveRecord::Base

end
