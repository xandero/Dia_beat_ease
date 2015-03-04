class ActivitiesController < ApplicationController
    def index
        @activities = Activity.all
    end

    def new
        @activity = Activity.new
    end

    def create
        activity_time = DateTime.parse(activity_params[:activity_date] + ' ' + activity_params[:activity_time])

        activity = @current_user.activities.create({
            user_id: @current_user.id,
            activityname: activity_params[:activityname],
            duration: activity_params[:duration],
            intensity: activity_params[:intensity],
            activity_time: activity_time
        })
        redirect_to activity
    end

    def show
        @activity = Activity.find params[:id]
    end

    def edit
        @activity = Activity.find params[:id]
    end

    def update
        activity = Activity.find params[:id]
        activity.update activity_params
        redirect_to activity
    end

    def destroy
        activity = Activity.find params[:id]
        activity.destroy
        redirect_to activities_path
    end

    private
    def activity_params
        params.require(:activity).permit(:user_id, :activityname, :duration, :intensity, :activity_time, :activity_date)
    end
end
