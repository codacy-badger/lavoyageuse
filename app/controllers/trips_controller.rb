class TripsController < ApplicationController
  before_action :params_user, only: %I(new create)

  def new
  end

  def create
    @trip = Trip.new(traveller: current_user, host: @user, beginning: trips_params[:beginning], end: trips_params[:end])
    if @trip.save!
      redirect_to @user
      flash[:success] = t('.success')
    else
      flash[:warning] = t('.warning')
      redirect_to new_user_trip_path(@user)
    end
  end

  private

  def params_user
    @user = User.find(params[:user_id])
  end

  def trips_params
    params.require(:trip).permit(:beginning, :end)
  end
end
