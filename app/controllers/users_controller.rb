class UsersController < ApplicationController
  before_action :params_user, only: %i(show update)

  def index
    @users = User.all
  end

  def show
    @comments = Comment.where(host: @user.id)
  end

  def update
    if @user.update(users_params)
      flash[:success] = t('.about_updated')
    else
      flash[:warning] = t('.about_failed')
    end
    redirect_to @user
  end

  private

  def params_user
    @user = User.find(params[:id])
  end

  def users_params
    params.require(:user).permit(:description, :sentence, :host)
  end
end

