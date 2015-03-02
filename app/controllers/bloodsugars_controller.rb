class BloodsugarsController < ApplicationController

  def index
    @bloodsugars = Bloodsugar.all

  end

  def import
     Bloodsugar.import(params[:file])
     render :json => Bloodsugar.all
  end

end
