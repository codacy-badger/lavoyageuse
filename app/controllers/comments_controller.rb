class CommentsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @comment = Comment.new(traveller: current_user, host: @user, content: comment_params[:content])
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
