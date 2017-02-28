class CsvExporterJob < ApplicationJob
  queue_as :default

  def perform
    file = CsvExporter.export_results
    puts file.inspect
    #NotificationMailer.csv_exported_email(file).deliver_now
  end
end
