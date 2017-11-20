class NotificationMailer < ApplicationMailer
  def csv_exported_email(file, to_email)
    @file = file
    mail(to: to_email, subject: "Your CSV has finished exporting")
  end
end
