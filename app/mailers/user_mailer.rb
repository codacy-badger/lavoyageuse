class UserMailer < ApplicationMailer
  before_action host_url, only: %[notification]

  def host_url
    @url = Rails.application.config.action_mailer.default_url_options
    @admin_mail = 'hello@lavoyageuse.com'
  end

  def notification(mail_content)
    @mail_content = mail_content
    mail(to: @admin_mail,
         subject: mail_content[:subject],
         track_opens: 'true')
  end
end
