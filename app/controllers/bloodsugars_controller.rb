class BloodsugarsController < ApplicationController

  def index
  end

  def create
     @bloodsugar = Bloodsugar.new(file_name: params[:file])
     if @bloodsugar.save!
        respond_to do |format|
          format.json{ render :json => @bloodsugar }
        end
     end
   end

  def new
  end

  def import
  end

end
