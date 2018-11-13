class UsersController < ApplicationController
  before_action :set_user, only: %i(show update edit moderate)
  before_action :set_user_comments, only: %i(show edit moderate)
  before_action :set_premium_plan, only: %i(show edit)

  def index
    @users = User.all_except(current_user)
    if params[:query]
      @map = true
      @search = params[:query][:content]
      @users = @users.near(params[:query][:content], 15).possible_hosts.order(host: :desc).mappable
      @markers = @users.map do |user|
        {
          lat: user.latitude,
          lng: user.longitude,
          user_id: user.id
        }
      end
    else
      @users = User.all_except(current_user)
      if i_am_moderator?
        @group_name = params[:group] ? params[:group][:name] : "hosts"
        #number of unvalidated hosts
        #number of visitors
        @users_count = { "hosts": @users.unvalidated_host.count,
                       "visitors": @users.visitor.count }
        case @group_name
        when "hosts"
          @users = @users.possible_hosts.order(host: :asc)
        when "members"
          @users = @users.not_hosts.order(updated_at: :desc)
        when "visitors"
          @users = @users.visitor.order(updated_at: :desc)
        when "suspendeds"
          @users = @users.suspended_members.order(updated_at: :desc)
        else
          @users
        end
      else
        @users = @users.possible_hosts.order(host: :desc)
      end
    end
  end

  def show
    if me?
      redirect_to edit_user_path(@user)
    elsif i_am_moderator?
      redirect_to moderate_user_path(@user)
    else
      redirect_to users_path if @user.not_accessible
    end
    @comments = @comments.for_public
  end

  def edit
    @order = @user.orders.last
    redirect_to @user unless me?
  end

  def moderate
    redirect_to @user unless current_user.moderator
  end

  def update
    if @user.update(users_params)
      flash[:success] = t('.success')
      if i_am_moderator? && !me?
        Moderation.create!(moderator: current_user, moderated: @user, action: params[:commit] + " : " + @user.id.to_s  )
        redirect_to moderate_user_path(@user)
      else
        redirect_to @user
      end
    else
      flash[:warning] = t('.warning')
    end

  end

  def set_premium_plan
    @premium_plan = Plan.find_by(name:"premium pass")
  end


  private

  def set_user_comments
    @comments = Comment.where(host: @user.id)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def users_params
    params.require(:user).permit(:description, :host, :home, :role)
  end
end

