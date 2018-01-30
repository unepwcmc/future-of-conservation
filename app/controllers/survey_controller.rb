class SurveyController < ApplicationController
  def index
    @answer_set             = AnswerSet.new
    @questions              = Question.order("RANDOM()")
    @demographic_questions  = DemographicQuestion.where(published: true).order(position: :asc)
    @questions_per_page     = 10
    @total_pages            = ((Question.count + DemographicQuestion.count) / @questions_per_page.to_f).ceil
  end
end
