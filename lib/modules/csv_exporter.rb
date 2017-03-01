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
        "X Axis (Scaled)", "Y Axis (Scaled)", self.json_headers_for(answer_set, "questions"),
        DemographicQuestion.find_by_short_name("age").text,
        DemographicQuestion.find_by_short_name("gender").text,
        DemographicQuestion.find_by_short_name("education").text,
        DemographicQuestion.find_by_short_name("educational_specialism").text,
        DemographicQuestion.find_by_short_name("country").text,
        DemographicQuestion.find_by_short_name("location_of_work").text,
        DemographicQuestion.find_by_short_name("total_countries_worked_in").text,
        DemographicQuestion.find_by_short_name("conservation_sectors").text,
        DemographicQuestion.find_by_short_name("experience_in_other_fields").text,
        DemographicQuestion.find_by_short_name("non_conservation_sectors").text,
        DemographicQuestion.find_by_short_name("professional_engagement").text,
        DemographicQuestion.find_by_short_name("seniority_of_current_role").text,
        DemographicQuestion.find_by_short_name("category_of_most_professional_work").text,
        DemographicQuestion.find_by_short_name("researcher_experience").text,
        DemographicQuestion.find_by_short_name("value_shaping_items").text,
        DemographicQuestion.find_by_short_name("shaping_values").text,
        DemographicQuestion.find_by_short_name("email").text
      ].flatten
    end


    def self.format_row(result)
      default = "N/A"

      [
        result.id,
        result.uuid,
        result.created_at,
        result.ip_address,
        result.classification.name,
        result.x_axis_scaled,
        result.y_axis_scaled,
        json_row_for(result, "questions"), #TODO - remove this or at least make sure it is ordered
        result.find_demographic_answer_by_key("age", default),
        result.find_demographic_answer_by_key("gender", default),
        result.find_demographic_answer_by_key("education", default),
        result.find_demographic_answer_by_key("educational_specialism", default),
        result.find_demographic_answer_by_key("country", default),
        result.find_demographic_answer_by_key("location_of_work", default),
        result.find_demographic_answer_by_key("total_countries_worked_in", default),
        result.find_demographic_answer_by_key("conservation_sectors", default),
        result.find_demographic_answer_by_key("experience_in_other_fields", default),
        result.find_demographic_answer_by_key("non_conservation_sectors", default),
        result.find_demographic_answer_by_key("professional_engagement", default),
        result.find_demographic_answer_by_key("seniority_of_current_role", default),
        result.find_demographic_answer_by_key("category_of_most_professional_work", default),
        result.find_demographic_answer_by_key("researcher_experience", default),
        result.find_demographic_answer_by_key("value_shaping_items", default),
        result.find_demographic_answer_by_key("shaping_values", default),
        result.find_demographic_answer_by_key("email", default)
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
