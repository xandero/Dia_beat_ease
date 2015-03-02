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
  #mount_uploader :file_name, BloodsugarUploader

  # def self.to_csv
  #   CSV.generate do |csv|
  #     csv << column_names
  #     all.each do |media|
  #       csv.media.attributes.values_at(*column_names)
  #     end
  #   end
  # end

  def self.import(file)
    # binding.pry
    #file_path = file.file_name.file.file
    # csv = CSV.read(file.tempfile, { :col_sep => ";" })

    # Define the headers here
    CSV.parse(file.tempfile, :col_sep => ";", :headers => true) do |row|
      #Bloodsugar.create! row.to_hash
      Bloodsugar.create!(readingtime: row['Date'], bslevel: row['Result'])
      end

    # CSV.foreach(csv.to_csv, headers: true) do |row|
    #   binding.pry
    # end

    # csv.each do |current_row|


    #   Media.create blood_sugar => ""
    #   binding.pry
    # end
    # foreach(file_path, headers: true) do |row|
    #   binding.pry


    #   Media.create! row.to_hash.permit
    # end

    # binding.prys
  end





end