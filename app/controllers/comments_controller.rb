class CommentsController < ApplicationController
  def create
    @user = User.find(comment_params[:current_id])
    @comment = Comment.new(user: current_user, host: @user.id, content: comment_params[:content])
    if @comment.save!
      flash[:notice] = t('.notice')
      redirect_to user_path(@user)
    end
  end

  private

  def comment_params
    params.require(:message).permit(:content, :current_id)
  end
end
