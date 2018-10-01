class CommentsController < ApplicationController
  def create
    @user = User.find(comment_params[:current_id])
    @comment = Comment.new(user: current_user, host: @user.id, content: comment_params[:comment])
    if @comment.save!
      flash[:notice] = t('.notice')
      redirect_to user_path(@user)
    end
  end

  private

  def comment_params
    params.require(:message).permit(:content, :hidden_value)
  end
end
