# == Schema Information
#
# Table name: answer_sets
#
#  id                        :integer          not null, primary key
#  ip_address                :string
#  answers                   :jsonb
#  x_axis_total              :float
#  y_axis_total              :float
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  uuid                      :string
#  x_axis_scaled             :float
#  y_axis_scaled             :float
#  classification_id         :integer
#  classification_strength_x :string
#  classification_strength_y :string
#
# Indexes
#
#  index_answer_sets_on_classification_id  (classification_id)
#

# An answer set holds a response to a survey,
# including a json snapshot of all questions and
# answers just incase the questions change

class AnswerSet < ApplicationRecord
  belongs_to :classification

  def self.build_new_from_params(params)
    answer_set = self.new
    answer_set.build_answers(params["answers"], params["demographics"])
    answer_set.calculate_scores
    answer_set.classify
    # Return the answer set
    answer_set
  end

  def build_answers(answers, demographic_answers)
    answers_array   = []
    answers.each do |key, value|
      question_id   = key.split("_").first
      question      = Question.find(question_id)
      question_data = {
        question_text:        question.text,
        question_x_weight:    question.x_weight,
        question_y_weight:    question.y_weight,
        answer_inputted:      value.to_i,
        x_answer_calculated:  calculate_answer(value, question.x_weight),
        y_answer_calculated:  calculate_answer(value, question.y_weight)
      }
      answers_array << question_data
    end

    self.answers = { questions: answers_array, demographics: demographic_answers }
  end

  def calculate_scores
    x_answers = select_by_axis(self.answers["questions"], :x_answer_calculated)
    x_total   = calculate_axis_total(x_answers, :x_answer_calculated)
    x_scaled  = scale_axis_total(x_total, :x_weight)

    y_answers = select_by_axis(self.answers["questions"], :y_answer_calculated)
    y_total   = calculate_axis_total(y_answers, :y_answer_calculated)
    y_scaled  = scale_axis_total(y_total, :y_weight)

    self.x_axis_total   = x_total
    self.x_axis_scaled  = x_scaled

    self.y_axis_total   = y_total
    self.y_axis_scaled  = y_scaled
  end

  def classify
    x, y = self.x_axis_scaled, self.y_axis_scaled
    self.classification             = choose_quadrant
    self.classification_strength_x  = find_quadrant_strength(x)
    self.classification_strength_y  = find_quadrant_strength(y)
  end

  def self.results_by_field(field, value, excluded_result_id=nil)
    self.where(
      "answers->'demographics'->>:field = :value",
      field: field, value: value
    ).reject{ |r| r.id == excluded_result_id }.pluck(:x_axis_scaled, :y_axis_scaled)
  end

  def self.results_by_age(min, max, excluded_result_id=nil)
    self.where(
      "answers->'demographics'->>'age' between :min and :max",
      min: min, max: max
    ).reject{ |r| r.id == excluded_result_id }.pluck(:x_axis_scaled, :y_axis_scaled)
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

  def find_answer_by_key_value(key, value, default=nil)
    self.answers["questions"].find {|h| h[key] == value} || default
  end

  def find_demographic_answer_by_key(key, default=nil)
    answer = self.answers.dig("demographics", key)
    return default if answer.nil?
    answer.empty? ? default : answer
  end

  private
    def select_by_axis(answers, axis)
      answers.select {|hash| hash[axis.to_s] != 0.0}
    end

    def calculate_answer(answer, weight)
      answer.to_f * weight.to_f
    end

    def calculate_axis_total(answers, axis)
      answers.inject(0) {|sum, hash| sum + hash[axis.to_s]}
    end

    #def calculate_axis_max_score(axis_weight)
      #self.answers["questions"].inject(0) {|sum, hash| sum + (hash["question_#{axis_weight.to_s}"] * 3) }
    #end

    def scale_axis_total(total, axis_weight)
      # 4 is the maximum weighting on a -4 to 4 scale
      # 3 is the maximum user inputted value on a -3 to 3 scale
      # Should scale to between -1 and +1
      # Ignores questions where the weighting is zero (for reliable scaling)
      valid_columns = ["x_weight", "y_weight"]
      valid_columns.include?(axis_weight.to_s) or raise "You are not permitted to count from this field"
      #max_score = (3 * 4) * Question.where("#{axis_weight.to_s} != 0.0").count
      # Max score needs to be calculated, which will be for a particular axis, sum the (weight of a question times by * 3)
      # answers.inject(0) {|sum, question| sum + (question.x_weight * 3)}

      case axis_weight.to_s
      when "x_weight"
        max_score = 177
      when "y_weight"
        max_score = 90
      end

      #max_score = calculate_axis_max_score(axis_weight.to_s)
      #Rails.logger.debug "MAX SCORE FOR #{axis_weight.to_s} IS #{max_score}"

      total.to_f / max_score.to_f
    end

    def choose_quadrant
      x, y = self.x_axis_scaled, self.y_axis_scaled

      if x.between?(-1, 0) && y.between?(-1, 0) # Bottom left
        Classification.find_by(name: "Critical Social Science")
      elsif x.between?(-1, 0) && y.between?(0, 1) # Top left
        Classification.find_by(name: "New Conservation")
      elsif x.between?(0, 1) && y.between?(-1, 0) # Bottom right
        Classification.find_by(name: "Traditional Conservation")
      elsif x.between?(0, 1) && y.between?(0, 1) # Top right
        Classification.find_by(name: "Market Biocentrism")
      end
    end

    def find_quadrant_strength(axis_total)
      axis_total.between?(-0.5, 0.5) ? "weak" : "strong"
    end
end
