require_relative '../../lib/modules/csv_exporter'

class CsvExporterJob < ApplicationJob
  queue_as :default

  def perform(to_email, from_date, to_date)
    file = CsvExporter.export_results(from_date, to_date)
    NotificationMailer.csv_exported_email(file.to_s, to_email).deliver_now
  end
end
