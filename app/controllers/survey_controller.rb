class SurveyController < ApplicationController
  def index
    @answer_set = AnswerSet.new
    @questions  = Question.order("RANDOM()")
  end
end
