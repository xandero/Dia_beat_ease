class FoodsController < ApplicationController

  # all action logic below will have to be changed around when working properly
  # needs to be related to the meal in question
  # some might not even be needed as they will be accessed via the meal's food array

  def test
  end

  def index

    # will need to show the foods that belong to a particular meal

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

    # error handling needs to be more thoroughly
    # binding.pry
    unless params["food"]["foodname"] == ""
      @food = Food.create food_params
      @meal = Meal.find params[:meal_id]

      # updates the value of meal.total_carbs every time a new food is added
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
    # updates total_carbs for meal in question upon deletion of a food
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
