class TripsController < ApplicationController
  before_action :user_params, only: %I(new create)

  def new
  end

  def create
  end

  private

  def user_params
    @user = User.find(params[:user_id])
  end
end
