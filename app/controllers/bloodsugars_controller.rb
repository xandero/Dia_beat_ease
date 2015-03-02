class BloodsugarsController < ApplicationController

  def index
    @bloodsugars = Bloodsugar.all
  end

  def create




     # if @bloodsugar.save!
     #    respond_to do |format|
     #      format.json{ render :json => @bloodsugar }
     #    end
     # end

   end

  def new
  end

  def import
     Bloodsugar.import(params[:file])
     render :json => Bloodsugar.all
  end

end
