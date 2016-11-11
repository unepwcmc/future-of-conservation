class SurveyController < ApplicationController
  def index
    @answer_set         = AnswerSet.new
    @questions          = Question.order("RANDOM()")
    @questions_per_page = 10
  end
end
