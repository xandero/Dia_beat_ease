class MealsController < ApplicationController

  def index
    @meals = @current_user.meals
  end

  def new
    @meal = Meal.new
  end

  def create
    meal = @current_user.meals.create(meal_params)
    redirect_to meal
  end

  def show
    @meal = Meal.find params[:id]
    @meal.total_carbs = @meal.foods.sum(:carbs).round(1)
  end

  # def complete
  #   @meal = Meal.find params[:meal_id]
  # end
  # refer to meal model for calculate_total_carbs method to calculate total meal carbs.

  # might not need this, as it is the foods themselves that will be edited
  def edit
    @meal = Meal.find params[:id]
  end

  def update
    meal = Meal.find params[:id]
    meal.update meal_params
    redirect_to meal_path
  end

  def destroy
    meal = Meal.find params[:id]
    meal.destroy
    redirect_to meal_path
  end

  private
  def meal_params
    params.require(:meal).permit(:meal_time, :user_id)
  end

end
