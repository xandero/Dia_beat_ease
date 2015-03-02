class FoodsController < ApplicationController

  # all action logic below will have to be changed around when working properly
  # needs to be related to the meal in question
  # some might not even be needed as they will be accessed via the meal's food array

  def test
    binding.pry
  end

  def index

    # will need to show the foods that belong to a particular meal
    @foods = Food.all
  end

  def new
    # binding.pry

    @food = Food.new
    @meal_id = params[:meal_id]
    @meal = Meal.find params[:meal_id]
    @foods = Food.all
  end

  def create
    # won't save it if the fields aren't filled in


    # binding.pry
    unless params["food"]["foodname"] == ""
      @food = Food.create food_params
    end
    @meal = Meal.find params["meal_id"]

    redirect_to meal_path(@meal)
  end

  def show
    @food = Food.find params[:id]
  end

  def edit
    # require 'pry'
    # binding.pry
    @food = Food.find params[:id]
    @meal_id = params[:meal_id]
  end

  def update
    # require 'pry'
    # binding.pry
    food = Food.find params[:id]
    food.update food_params
    redirect_to meal_path(food.meal_id)
  end

  def destroy
    food = Food.find params[:id]
    food.destroy
    # require 'pry'
    # binding.pry
    redirect_to "/meals/#{ params[:meal_id] }"
  end

  private
  def food_params
    params.require(:food).permit(:foodname, :quantity, :serving_size_qty, :serving_size_unit, :carbs, :serving_size_weight, :insulin_required, :consumed_at, :meal_id)
  end

end
