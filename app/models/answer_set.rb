# == Schema Information
#
# Table name: answer_sets
#
#  id                :integer          not null, primary key
#  ip_address        :string
#  answers           :jsonb
#  x_axis_total      :float
#  y_axis_total      :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  uuid              :string
#  x_axis_scaled     :float
#  y_axis_scaled     :float
#  classification_id :integer
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
    answers             = params["answers"]
    demographic_answers = params["demographics"]
    answers_array       = []

    answers.each do |key, value|
      question_id   = key.split("_").first
      question      = Question.find(question_id)
      answer        = value
      question_data = {
        question_text:        question.text,
        question_x_weight:    question.x_weight,
        question_y_weight:    question.y_weight,
        answer_inputted:      value.to_i,
        x_answer_calculated:  self.calculate_answer(value, question.x_weight),
        y_answer_calculated:  self.calculate_answer(value, question.y_weight)
        #question_version_number: 3,#question.version.index,
      }

      answers_array << question_data
    end

    x_axis_total = self.calculate_axis_total(self.select_by_axis(answers_array, :x_answer_calculated), :x_answer_calculated)
    x_axis_scaled = self.scale_axis_total(x_axis_total)

    y_axis_total = self.calculate_axis_total(self.select_by_axis(answers_array, :y_answer_calculated), :y_answer_calculated)
    y_axis_scaled = self.scale_axis_total(y_axis_scaled)

    self.new(
      answers: { questions: answers_array, demographics: demographic_answers },
      x_axis_total: x_axis_total,
      y_axis_total: y_axis_total,
      x_axis_scaled: x_axis_scaled,
      y_axis_scaled: y_axis_scaled,
      classification: self.classify(x_axis_scaled, y_axis_scaled)
    )
  end

  def self.classify(x, y)
    if x.between?(-0.1, 0.1) && y.between?(-0.1, 0.1)
      Classification.find_by(name: "Undecided") # Center square
    elsif x.between?(-1, 0) && y.between?(-0.1, 0.1)
      Classification.find_by(name: "Traditional Conservation and Critical Social Science") # Left boundary
    elsif x.between?(0, 1) && y.between?(-0.1, 0.1)
      Classification.find_by(name: "Market Biocentrism and New Conservation") # Right boundary
    elsif x.between?(-0.1, 0.1) && y.between?(-1, 0)
      Classification.find_by(name: "Critical Social Science and New Conservation") # Bottom boundary
    elsif x.between?(-0.1, 0.1) && y.between?(0, 1)
      Classification.find_by(name: "Traditional Conservation and Market Biocentrism") # Top boundary
    elsif x.between?(-1, 0) && y.between?(-1, 0)
      Classification.find_by(name: "Critical Social Science") # Bottom left
    elsif x.between?(-1, 0) && y.between?(0, 1)
      Classification.find_by(name: "Traditional Conservation") # Top left
    elsif x.between?(0, 1) && y.between?(-1, 0)
      Classification.find_by(name: "New Conservation") # Bottom right
    elsif x.between?(0, 1) && y.between?(0, 1)
      Classification.find_by(name: "Market Biocentrism") #Top right
    end
  end

  private
    def self.select_by_axis(answers, axis)
      answers.select {|h| h[axis] != 0}
    end

    def self.calculate_answer(answer, weight)
      answer.to_f * weight.to_f
    end

    def self.calculate_axis_total(answers, axis)
      answers.inject(0) {|sum, hash| sum + hash[axis]}
    end

    def self.scale_axis_total(total)
      # 4 is the maximum weighting on a -4 to 4 scale and 3 is the maximum user inputted value on a -3 to 3 scale
      # Should scale to between -1 and +1
      max_score = (3 * 4) * Question.count
      total.to_f / max_score.to_f
    end
end
