class CommentsController < ApplicationController
  before_action :params_comment, only: %i(create update)

  def create
    @comment = Comment.new(traveller: current_user, host: @user, content: comment_params[:content])
    if @comment.save!
      flash[:notice] = t('.notice')
      redirect_to user_path(@user)
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:success] = "comment suspended"
      redirect_to @user
    end
    if current_user.moderator
      Moderation.create!(moderator: current_user, moderated: @user, action: params[:commit] + " : " + @comment.id.to_s  )
    end
  end

  private

  def params_comment
    @user = User.find(params[:user_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :suspended)
  end
end
