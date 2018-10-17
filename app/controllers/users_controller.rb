class UsersController < ApplicationController
  before_action :params_user, only: %i(show update edit moderate)
  before_action :user_comments, only: %i(show edit moderate)

  def index
    if params[:query]
      @users = User.near(params[:query][:content], 100).order(host: :desc)
    else
      if current_user.moderator?
        @users = User.all_except(current_user).order(host: :desc)
      else
        @users = User.hosts.all_except(current_user).order(host: :desc)
      end
    end
  end

  def show
    if current_user == @user
      redirect_to edit_user_path(@user)
    else
      redirect_to users_path unless @user.validated_host?
    end
  end

  def edit
    redirect_to @user unless current_user == @user
  end

  def moderate
    redirect_to @user unless current_user.moderator?

  end

  def update
    if @user.update(users_params)
      flash[:success] = t('.success')
    else
      flash[:warning] = t('.warning')
    end
    if current_user.moderator?
      redirect_to moderate_user_path(@user)
    else
      redirect_to @user
    end
  end

  def get_premium

  end


  private

  def user_comments
    @comments = Comment.where(host: @user.id)
  end

  def params_user
    @user = User.find(params[:id])
  end

  def users_params
    params.require(:user).permit(:description, :host, :home)
  end
end

