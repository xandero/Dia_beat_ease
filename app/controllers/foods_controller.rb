class FoodsController < ApplicationController

  before_action :check_if_logged_in, :only => [:index]

  def test
  end

  def index
    render :json => Meal.where(:user_id => @current_user.id)
  end

  # For carb chart
  def carbs
    carbs = Meal.pluck :total_carbs
    render :json => carbs 
  end

  def mealtime
    mealtime = Meal.pluck :meal_time
    render :json => mealtime
  end

  def carbs_lastthirty
    carbs = Meal.where(:user_id => @current_user.id).limit(30).pluck(:total_carbs)
    render :json => carbs   
  end

  def mealtime_lastthirty
    mealtimeStrf =[]
    mealtime = Meal.where(:user_id => @current_user.id).limit(30).pluck(:meal_time)
      mealtime.each do |time|
        mealtimeStrf << time.strftime("%R, %d/%m")
      end
    render :json => mealtimeStrf
  end

  def new
    @food = Food.new
    @meal_id = params[:meal_id]
    @meal = Meal.find params[:meal_id]
    @foods = Food.all
  end

  def create
    unless params["food"]["foodname"] == ""
      @food = Food.create food_params
      @meal = Meal.find params[:meal_id]

      # Updates the value of meal.total_carbs every time a new food is added
      sum = 0
      @meal.foods.each do |food|
        sum += (food.carbs * food.quantity)
        sum
      end
      @meal.update_attribute(:total_carbs, sum.round)

    end
    @meal = Meal.find params["meal_id"]

    respond_to do |format|
      format.json { render :json => @meal.foods }
    end
  end

  def show
    @food = Food.find params[:id]
  end

  def edit
    @food = Food.find params[:id]
    @meal_id = params[:meal_id]
    @meal = Meal.find params[:meal_id]
  end

  def update
    food = Food.find params[:id]
    food.update food_params
    redirect_to meal_path(food.meal_id)
  end

  def destroy
    food = Food.find params[:id]
    food.destroy
    @meal = Meal.find params[:meal_id]
    # Updates total_carbs for meal in question upon deletion of a food
    sum = 0
    @meal.foods.each do |food|
      sum += (food.carbs * food.quantity)
      sum
    end
    @meal.update_attribute(:total_carbs, sum.round)
    redirect_to "/meals/#{ params[:meal_id] }"
  end

  private
  def food_params
    params.require(:food).permit(:foodname, :quantity, :serving_size_qty, :serving_size_unit, :carbs, :serving_size_weight, :insulin_required, :consumed_at, :meal_id)
  end

end
