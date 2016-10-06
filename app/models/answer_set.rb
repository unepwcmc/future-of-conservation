# == Schema Information
#
# Table name: answer_sets
#
#  id           :integer          not null, primary key
#  ip_address   :string
#  answers      :jsonb
#  x_axis_total :float
#  y_axis_total :float
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

# An answer set holds a response to a survey,
# including a json snapshot of all questions and
# answers just incase the questions change

class AnswerSet < ApplicationRecord
  def self.build_new_from_params(params)
    answers_array = []

    params.each do |key, value|
      question_id   = key.split("_").first
      question      = Question.find(question_id)
      answer        = value
      question_data = {
        question_text: question.text,
        question_weight: question.weight,
        question_version_number: 3,#question.version.index,
        question_axis: question.axis,
        answer_inputted: value.to_i,
        answer_calculated: self.calculate_answer(value, question.weight)
      }

      answers_array << question_data
    end

    self.new(
      answers: answers_array.to_json,
      x_axis_total: self.calculate_axis_total(answers_array.select {|h| h[:question_axis] == "X"}),
      y_axis_total: self.calculate_axis_total(answers_array.select {|h| h[:question_axis] == "Y"})
    )
  end

  private
    def self.calculate_answer(answer, weight)
      answer.to_f * weight.to_f
    end

    def self.calculate_axis_total(answers)
      answers.inject(0) {|sum, hash| sum + hash[:answer_calculated]}
    end

    def self.scale_axis_total(total)
    end
end
