class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.mailer["username"]
  layout 'mailer'
end
