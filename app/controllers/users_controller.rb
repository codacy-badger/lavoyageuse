class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @comments = Comment.where(host: @user.id)
  end
end
