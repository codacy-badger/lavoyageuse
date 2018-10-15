class CommentsController < ApplicationController
  def create
    @user = comment_params(:user)
    @comment = Comment.new(user: current_user, host: @user, content: comment_params[:content])
    if @comment.save!
      flash[:notice] = t('.notice')
      redirect_to user_path(@user)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
