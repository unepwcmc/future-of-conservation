class ResultsController < ApplicationController
  def show
    @results = AnswerSet.find_by(uuid: params[:uuid])
  end
end
