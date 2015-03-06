class ActivitiesController < ApplicationController
    
    before_action :check_if_logged_in, :only => [:index]

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

    # ACTIVITY CHART ACTIONS
    def duration
        activity = Activity.pluck :duration
        render :json => activity
    end

    def activity_time
        activity_time = Activity.pluck :activity_time
        render :json => activity_time
    end

    def duration_lastthirty
        activities = Activity.where(:user_id => @current_user.id).limit(30).pluck(:duration)
        render :json => activities  
    end

    def activity_time_lastthirty
        activity_timeStrf =[]
        activity_time = Activity.where(:user_id => @current_user.id).limit(30).pluck(:activity_time)
            activity_time.each do |time|
                activity_timeStrf<< time.strftime("%R, %d/%m")
            end
        render :json => activity_timeStrf
    end

    private
    def activity_params
        params.require(:activity).permit(:user_id, :activityname, :duration, :intensity, :activity_time, :activity_date)
    end

    def check_if_logged_in
        redirect_to(root_path) unless @current_user.present?
    end
end
