class MessagesController < ApplicationController

  def create
    @user = User.find(message_params[:hidden_value])
    @message = Message.new(user: current_user, host: @user.id, content: message_params[:content])
    if @message.save!
      flash[:notice] = t('.notice')
    else
      flash[:warning] = t('.warning')
    end
    redirect_to @user
  end

  private

  def message_params
    params.require(:message).permit(:content, :hidden_value)
  end
end
