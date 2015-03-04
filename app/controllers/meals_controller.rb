class MealsController < ApplicationController

  def index
    @meals = @current_user.meals
    sum = 0

  end

  def new
    @meal = Meal.new
  end

  def create
    meal_time = DateTime.parse(meal_params[:meal_date] + ' ' + meal_params[:meal_time])

    meal = @current_user.meals.create({
      user_id: meal_params[:user_id],
      total_carbs: meal_params[:total_carbs],
      meal_time: meal_time
    })
    redirect_to meal
  end

  def show
    # binding.pry
    @meal = Meal.find params[:id]
  end


  def edit
    @meal = Meal.find params[:id]
  end

  def update
    meal_time = DateTime.parse(meal_params[:meal_date] + ' ' + meal_params[:meal_time])

    meal = Meal.find params[:id]
    meal.update({
      user_id: meal_params[:user_id],
      total_carbs: meal_params[:total_carbs],
      meal_time: meal_time
    })
    redirect_to meal_path
  end

  def destroy
    meal = Meal.find params[:id]
    meal.destroy
    redirect_to meals_path
  end

  private
  def meal_params
    params.require(:meal).permit(:meal_time, :meal_date, :user_id, :total_carbs)
  end

end
