class NotificationMailer < ApplicationMailer
  def csv_exported_email(file)
    @file = file
    mail(to: Rails.application.secrets.notification_email, subject: "Your CSV has finished exporting")
  end
end
