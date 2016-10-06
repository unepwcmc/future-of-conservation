class AnswerSetsController < ApplicationController
  def create
    # Get :answers from params and parse the scales to json
    @answer_set = AnswerSet.build_new_from_params(params["answers"])
    @answer_set.ip_address = request.remote_ip

    if @answer_set.save
      redirect_to root_path, notice: 'Your response was successfully created.'
    else
      redirect_to root_path, notice: 'Something went wrong'
    end
  end
end
