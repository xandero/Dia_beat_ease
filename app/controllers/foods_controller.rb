class FoodsController < ApplicationController

  # all action logic below will have to be changed around when working properly
  # needs to be related to the meal in question
  # some might not even be needed as they will be accessed via the meal's food array

  def index

    # will need to show the foods that belong to a particular meal
    @foods = Food.all
  end

  def new
    @food = Food.new
    @meal_id = params[:meal_id]
  end

  def create
    # needs to be new food within a meal object's foods array
    food = Food.create food_params
    redirect_to meal_path(food.meal.id)
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
    redirect_to meal_food_path(food.meal_id, food.id)
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
