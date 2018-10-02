class MessengersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:contact_form]
  before_action :message_from_params, only: %i[contact_form]

  def contact_form
    @valid_email = email_valid(@message[:email])
    @valid_comment = comment_valid(@message[:comment])
    @human = params[:iamhuman].present?

    if @valid_email && @valid_comment && @human
      session[:contact_email] = session[:contact_name] = session[:contact_comment] = nil
      flash[:success] = t('.notice')
      UserMailer.notification({ subject: t('.subject'),
                                email: "test@la-voyageuse.com",
                                name: params_message[:name],
                                content: params_message[:comment]}).deliver_now
      redirect_to root_path
    else
      session[:contact_email] = @message[:email]
      session[:contact_name] = @message[:name]
      session[:contact_comment] = @message[:comment]
      flash[:warning1] = t('.be_human') unless @human
      flash[:warning2] = t('.invalid_email') unless @valid_email
      flash[:warning3] = t('.blank_email') unless @email_presence
      flash[:warning4] = t('.invalid_comment') unless @valid_comment
      redirect_to contact_path
    end
  end

  private

  def message_from_params
    @message = params_message
  end

  def params_message
    params.require(:message).permit(:email, :name, :comment, :iamhuman)
  end
end
