class MessagesController < ApplicationController

  def create
    @user = User.find(message_params[:hidden_value])
    @message = Message.new(user: current_user, host: @user.id, content: message_params[:content])
    if @message.save!
      UserMailer.mail_to_host({  subject: t('.subject'),
                                email: "test@la-voyageuse.com",
                                btn_text: t('.mail_to'),
                                btn_link: "mailto:#{current_user.email}",
                                photo: "https://res.cloudinary.com/dfcsmghw4/image/upload/v1538510054/transactional/photo-1528082448537-7a6db294be9f.jpg",
                                sender_photo: current_user.photo.url,
                                sender_name: current_user.hidden_full_name,
                                sender_email: current_user.email,
                                name: @message.user.hidden_full_name,
                                content: @message.content}).deliver_now
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
