class CsvExporterJob < ApplicationJob
  queue_as :default

  def perform(results)
    file = CsvExporter.export_results(results)
    NotificationMailer.csv_exported_email(file).deliver_now
  end
end
