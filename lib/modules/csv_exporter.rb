require 'csv'

module CsvExporter
  def self.export_results
    results = AnswerSet.all
    folder = Rails.root.join("public", "csv_exports")
    FileUtils.mkdir_p(folder)
    filepath = folder.join("csv_export_#{DateTime.now.to_i}.csv")
    # Use last answer set to grab the headers as these may change
    latest = AnswerSet.first

    CSV.open(filepath, "wb") do |csv|
      csv << self.headers(latest)
      results.each do |result|
        csv << self.format_row(result)
      end
    end

    filepath
  end

  private
    def self.headers(answer_set)
      [
        "ID", "UUID", "Created at", "IP Address", "Classification Name",
        "X Axis (Scaled)", "Y Axis (Scaled)", self.json_headers_for(answer_set, "questions")
      ].flatten
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
        json_row_for(result, "questions")
      ].flatten
    end

    def self.json_headers_for(result, question_type)
      headers = []
      result.answers[question_type].each {|q| headers << q["question_text"] || ""}
      headers
    end

    def self.json_row_for(result, question_type)
      row = []
      result.answers[question_type].each {|q| row << q["answer_inputted"] || ""}
      row
    end
end
