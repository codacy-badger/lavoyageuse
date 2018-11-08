class UsersController < ApplicationController
  before_action :params_user, only: %i(show update edit moderate)
  before_action :user_comments, only: %i(show edit moderate)
  before_action :set_premium_plan, only: %i(show edit)

  def index
    if params[:query]
      @users = User.near(params[:query][:content], 100).order(host: :desc)
    else
      if current_user.moderator
        @hosts = User.possible_hosts.all_except(current_user).order(host: :asc)
        @not_host_members = User.not_hosts.all_except(current_user).order(updated_at: :desc)
        @unvalidated_members = User.unvalidated_members.all_except(current_user).order(updated_at: :desc)
        @suspended_members = User.suspended_members.all_except(current_user).order(updated_at: :desc)
      else
        @users = User.possible_hosts.all_except(current_user).order(host: :desc)
      end
    end
  end

  def show
    if current_user == @user
      redirect_to edit_user_path(@user)
    elsif current_user.moderator
      redirect_to moderate_user_path(@user)
    else
      redirect_to users_path if @user.not_accessible
    end
    @comments = @comments.for_public
  end

  def edit
    redirect_to @user unless current_user == @user
  end

  def moderate
    redirect_to @user unless current_user.moderator
  end

  def update
    if @user.update(users_params)
      flash[:success] = t('.success')
    else
      flash[:warning] = t('.warning')
    end
    if current_user.moderator?
      Moderation.create!(moderator: current_user, moderated: @user, action: params[:commit] + " : " + @user.id.to_s  )
      redirect_to moderate_user_path(@user)
    else
      redirect_to @user
    end
  end

  def set_premium_plan
    @premium_plan = Plan.find_by(name:"premium pass")
  end


  private

  def user_comments
    @comments = Comment.where(host: @user.id)
  end

  def params_user
    @user = User.find(params[:id])
  end

  def users_params
    params.require(:user).permit(:description, :host, :home, :role)
  end
end

