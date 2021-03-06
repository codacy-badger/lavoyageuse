class UserMailer < ApplicationMailer
  before_action :host_url, only: %[notification]

  def notification(mail_content)
    @mail_content = mail_content
    #TODO change mail to
    mail(to: "test@la-voyageuse.com",
         subject: mail_content[:subject],
         track_opens: 'true')
  end

  def mail_to_host(mail_content)
    @mail_content = mail_content
    #TODO change mail to
    mail(to: "test@la-voyageuse.com",
         subject: mail_content[:subject],
         track_opens: 'true')
  end

  def custom_mail(mail_content)
    @mail_content = mail_content
    #TODO change mail to
    mail(to: "test@la-voyageuse.com",
         subject: mail_content[:subject],
         track_opens: 'true')
  end

  private

  def host_url
    @url = Rails.application.config.action_mailer.default_url_options
    @admin_mail = 'test@la-voyageuse.com'
  end

end
