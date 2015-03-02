class BloodsugarsController < ApplicationController

  def index
    @bloodsugars = Bloodsugar.all

  end

  def import
     Bloodsugar.import(params[:file])
     render :json => Bloodsugar.all
  end

  def data
    render :json => Bloodsugar.all
    # binding.pry
  end

end
