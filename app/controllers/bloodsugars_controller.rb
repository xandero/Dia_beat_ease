class BloodsugarsController < ApplicationController

  before_action :check_if_logged_in, :only => [:index]

  def index
    @bloodsugars = Bloodsugar.where(:user_id => @current_user.id)
  end

  def import
    # IMPORT AND SPLIT CSV DATA
    CSV.parse((params[:file]).tempfile, :col_sep => ";", :headers => true) do |row|
      if row['Date'] && row['Time']
        # CONVERT CSV STRING TO A TIME OBJECT
        csvreadingtime = Time.parse(row['Date'] + 'T' + row['Time'])
        # COMPARE CSV DATE WITH DATABASE
         if @current_user.bloodsugars.none? { |x| x.readingtime == csvreadingtime }
            @current_user.bloodsugars.create!(readingtime: csvreadingtime, bslevel: row['Result'], user_id: @current_user.id )
          else
            # TO DO - COVERT TO PROMPT FOR USER
            puts "this data has been duplicated"
         end
      end
    end
     render :json => Bloodsugar.where(:user_id => @current_user.id)
  end

  def data
    render :json => Bloodsugar.where(:user_id => @current_user.id)
  end

  private
  def check_if_logged_in
    redirect_to(root_path) unless @current_user.present?
  end

end
