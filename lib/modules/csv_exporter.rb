module CsvExporter
  def self.export_results(results)
    CSV.generate(headers: true) do |csv|
      csv << self.headers
      results.each do |result|
        csv << self.format_row(result)
      end
    end
  end

  private
    def self.headers
      [
        "ID", "UUID", "Created at", "IP Address", "Classification Name",
        "X Axis (Scaled)", "Y Axis (Scaled)", "Answers", "Demographic Answers"
      ]
    end

    def self.format_row(result)
      [
        result.id,
        result.uuid,
        result.created_at,
        result.ip_address,
        result.classification.name,
        result.x_axis_scaled,
        result.y_axis_scaled,
        result.answers["questions"],
        result.answers["demographic_questions"]
      ]
    end
end
