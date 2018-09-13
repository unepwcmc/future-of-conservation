require 'csv'

BOM = "\xEF\xBB\xBF" # byte order mark
OPEN_MODE = "wb:UTF-16LE:UTF-8"

module CsvExporter
  def self.export_results(from_date, to_date)
    I18n.locale = :en
    folder = Rails.root.join("public", "csv_exports")
    FileUtils.mkdir_p(folder)
    filepath = folder.join("csv_export_#{DateTime.now.to_i}.csv")
    # Use last answer set to grab the headers as these may change
    latest = AnswerSet.last

    begin
      File.open(filepath, OPEN_MODE) do |f|
        csv_file = CSV.generate({:col_sep => "\t"}) do |csv|
          csv << self.headers(latest)

          if from_date.empty? && to_date.empty?
            @answersets = AnswerSet.find_in_batches(batch_size: 250)
          else
            from_date   = self.date_valid?(from_date) ? from_date : AnswerSet.first.created_at
            to_date     = self.date_valid?(to_date)   ? to_date   : DateTime.now
            to_date     = Date.parse(to_date).end_of_day

            @answersets = AnswerSet.where("created_at >= ? AND created_at <= ?", from_date, to_date).find_in_batches(batch_size: 250)
          end

          @answersets.each do |batch|
            batch.each do |result|
              csv << self.format_row(result)
            end
          end
        end

        f.write BOM
        f.write(csv_file)
      rescue Exception => e
        Appsignal.send_error(e)
      end
    end

    filepath
  end

  private
    def self.headers(answer_set)
      [
        "ID",
        "UUID",
        "Created at",
        "IP Address",
        "Classification Name",
        "X Axis (Scaled)",
        "Y Axis (Scaled)",
        Question.find_by_short_name("humans_separate").text,
        Question.find_by_short_name("provides_benefits").text,
        Question.find_by_short_name("nature_sake").text,
        Question.find_by_short_name("ethical_imperative").text,
        Question.find_by_short_name("impact_rich").text,
        Question.find_by_short_name("biological_science").text,
        Question.find_by_short_name("people_displaced").text,
        Question.find_by_short_name("pristine_nature").text,
        Question.find_by_short_name("strict_protected_areas").text,
        Question.find_by_short_name("science_based").text,
        Question.find_by_short_name("own_sake").text,
        Question.find_by_short_name("value_landscapes").text,
        Question.find_by_short_name("public_support").text,
        Question.find_by_short_name("with_capitalism").text,
        Question.find_by_short_name("corporations_pragmatic").text,
        Question.find_by_short_name("population growth").text,
        Question.find_by_short_name("affection_income").text,
        Question.find_by_short_name("advancing_wellbeing").text,
        Question.find_by_short_name("emotional_separation").text,
        Question.find_by_short_name("ethical_values").text,
        Question.find_by_short_name("ecosystem_goal").text,
        Question.find_by_short_name("economic_arguments").text,
        Question.find_by_short_name("displace_motivations").text,
        Question.find_by_short_name("giving_voice_improves").text,
        Question.find_by_short_name("reform_global_trade").text,
        Question.find_by_short_name("Non_native_species").text,
        Question.find_by_short_name("impact_incomes").text,
        Question.find_by_short_name("support_corporations").text,
        Question.find_by_short_name("seek_no_harm").text,
        Question.find_by_short_name("giving_voice_ethical").text,
        Question.find_by_short_name("economic_growth").text,
        Question.find_by_short_name("communities_manage").text,
        Question.find_by_short_name("win_win").text,
        Question.find_by_short_name("rationales_weakens").text,
        Question.find_by_short_name("emphasise_value").text,
        Question.find_by_short_name("doom_gloom").text,
        Question.find_by_short_name("biological_diversity").text,
        Question.find_by_short_name("severe_perturbations").text,
        DemographicQuestion.find_by_short_name("age").text,
        DemographicQuestion.find_by_short_name("gender").text,
        DemographicQuestion.find_by_short_name("education").text,
        DemographicQuestion.find_by_short_name("educational_specialism").text,
        DemographicQuestion.find_by_short_name("country").text,
        DemographicQuestion.find_by_short_name("location_of_work").text,
        DemographicQuestion.find_by_short_name("conservation_sectors").text,
        DemographicQuestion.find_by_short_name("experience_in_other_fields").text,
        DemographicQuestion.find_by_short_name("non_conservation_sectors").text,
        DemographicQuestion.find_by_short_name("professional_engagement").text,
        DemographicQuestion.find_by_short_name("seniority_of_current_role").text,
        DemographicQuestion.find_by_short_name("category_of_most_professional_work").text,
        DemographicQuestion.find_by_short_name("researcher_experience").text,
        DemographicQuestion.find_by_short_name("value_shaping_items").text,
        DemographicQuestion.find_by_short_name("shaping_values").text,
        DemographicQuestion.find_by_short_name("email").text,
        DemographicQuestion.find_by_short_name("bto_survey").text,
        DemographicQuestion.find_by_short_name("fpt_survey").text,
        'Language'
      ].flatten.map {|q| q.gsub(",", "") }
    end


    def self.format_row(result)
      default = "n/a"
      row = [
        result.id,
        result.uuid,
        result.created_at,
        result.ip_address,
        result.classification.name,
        result.x_axis_scaled,
        result.y_axis_scaled,
        result.find_answer_by_key_value("short_name", "humans_separate", default),
        result.find_answer_by_key_value("short_name", "provides_benefits", default),
        result.find_answer_by_key_value("short_name", "nature_sake", default),
        result.find_answer_by_key_value("short_name", "ethical_imperative", default),
        result.find_answer_by_key_value("short_name", "impact_rich", default),
        result.find_answer_by_key_value("short_name", "biological_science", default),
        result.find_answer_by_key_value("short_name", "people_displaced", default),
        result.find_answer_by_key_value("short_name", "pristine_nature", default),
        result.find_answer_by_key_value("short_name", "strict_protected_areas", default),
        result.find_answer_by_key_value("short_name", "science_based", default),
        result.find_answer_by_key_value("short_name", "own_sake", default),
        result.find_answer_by_key_value("short_name", "value_landscapes", default),
        result.find_answer_by_key_value("short_name", "public_support", default),
        result.find_answer_by_key_value("short_name", "with_capitalism", default),
        result.find_answer_by_key_value("short_name", "corporations_pragmatic", default),
        result.find_answer_by_key_value("short_name", "population growth", default),
        result.find_answer_by_key_value("short_name", "affection_income", default),
        result.find_answer_by_key_value("short_name", "advancing_wellbeing", default),
        result.find_answer_by_key_value("short_name", "emotional_separation", default),
        result.find_answer_by_key_value("short_name", "ethical_values", default),
        result.find_answer_by_key_value("short_name", "ecosystem_goal", default),
        result.find_answer_by_key_value("short_name", "economic_arguments", default),
        result.find_answer_by_key_value("short_name", "displace_motivations", default),
        result.find_answer_by_key_value("short_name", "giving_voice_improves", default),
        result.find_answer_by_key_value("short_name", "reform_global_trade", default),
        result.find_answer_by_key_value("short_name", "Non_native_species", default),
        result.find_answer_by_key_value("short_name", "impact_incomes", default),
        result.find_answer_by_key_value("short_name", "support_corporations", default),
        result.find_answer_by_key_value("short_name", "seek_no_harm", default),
        result.find_answer_by_key_value("short_name", "giving_voice_ethical", default),
        result.find_answer_by_key_value("short_name", "economic_growth", default),
        result.find_answer_by_key_value("short_name", "communities_manage", default),
        result.find_answer_by_key_value("short_name", "win_win", default),
        result.find_answer_by_key_value("short_name", "rationales_weakens", default),
        result.find_answer_by_key_value("short_name", "emphasise_value", default),
        result.find_answer_by_key_value("short_name", "doom_gloom", default),
        result.find_answer_by_key_value("short_name", "biological_diversity", default),
        result.find_answer_by_key_value("short_name", "severe_perturbations", default),
        result.find_demographic_answer_by_key("age", default),
        result.find_demographic_answer_by_key("gender", default),
        result.find_demographic_answer_by_key("education", default),
        result.find_demographic_answer_by_key("educational_specialism", default),
        result.find_demographic_answer_by_key("country", default),
        self.format_multiple_answer(result.find_demographic_answer_by_key("location_of_work"), default),
        self.format_multiple_answer(result.find_demographic_answer_by_key("conservation_sectors"), default),
        result.find_demographic_answer_by_key("experience_in_other_fields", default),
        self.format_multiple_answer(result.find_demographic_answer_by_key("non_conservation_sectors"), default),
        result.find_demographic_answer_by_key("professional_engagement", default),
        result.find_demographic_answer_by_key("seniority_of_current_role", default),
        result.find_demographic_answer_by_key("category_of_most_professional_work", default),
        result.find_demographic_answer_by_key("researcher_experience", default),
        self.format_multiple_answer(result.find_demographic_answer_by_key("value_shaping_items"), default),
        result.find_demographic_answer_by_key("shaping_values", default),
        result.find_demographic_answer_by_key("email", default),
        result.find_demographic_answer_by_key("bto_survey", default),
        result.find_demographic_answer_by_key("fpt_survey", default),
        result.language || "en"
      ].flatten

      row.map do |answer|
        # For text answers, replace commas
        if answer.is_a?(String)
          answer.gsub(",", "")
        else
          answer
        end
      end
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

    def self.format_multiple_answer(answer, default)
      return default if answer.nil?
      answer = Array.wrap(answer.values) if answer.is_a?(Hash)
      answer = answer.reject(&:blank?).join("|")
      answer.empty? ? default : answer
    end

    private

    def self.date_valid?(date)
      return nil if date.blank?
      year, month, day = date&.split("-").map(&:to_i)
      Date.valid_date?(year, month, day)
    end
end
