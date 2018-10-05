class UsersController < ApplicationController
  before_action :params_user, only: %i(show update edit)

  def index
    @users = User.all.order(host: :desc)
  end

  def show
    if current_user == @user
      redirect_to edit_user_path(@user)
    else
      redirect_to users_path unless @user.validated_host?
    end
    @comments = Comment.where(host: @user.id)
  end

  def edit
    redirect_to @user if current_user != @user
    @comments = Comment.where(host: @user.id)
  end

  def update
    if @user.update(users_params)
      flash[:success] = t('.success')
    else
      flash[:warning] = t('.warning')
    end
    redirect_to @user
  end

  private

  def params_user
    @user = User.find(params[:id])
  end

  def users_params
    params.require(:user).permit(:description, :host, :home)
  end
end

