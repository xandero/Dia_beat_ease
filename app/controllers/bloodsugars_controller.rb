class BloodsugarsController < ApplicationController

  def index
    @bloodsugars = Bloodsugar.all

  end

  def import
    CSV.parse((params[:file]).tempfile, :col_sep => ";", :headers => true) do |row|
    # Bloodsugar.create! new row and << csv data to database
      if row['Date'] && row['Time']
        # if we have this blood reading at this date, don't create this entry 
        # Bloodsugar.create!(readingtime: (row['Date'] + 'T' + row['Time']), bslevel: row['Result'] )
        # (Bloodsugar.all).each do |x|
        #    if x.bslevel != row['Result']
              Bloodsugar.create!(readingtime: (row['Date'] + 'T' + row['Time']), bslevel: row['Result'], user_id: @current_user.id )
        #     else
        #       puts "this data has been duplicated"
        #    end
        # end

      end
    end
     render :json => Bloodsugar.all
  end

  def data
    render :json => Bloodsugar.where(:user_id => @current_user.id)
    # binding.pry
  end

end
