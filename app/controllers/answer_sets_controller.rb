class AnswerSetsController < ApplicationController
  def create
    # Get :answers from params and parse the scales to json
    @answer_set             = AnswerSet.build_new_from_params(params)
    @answer_set.ip_address  = request.remote_ip
    @answer_set.uuid        = SecureRandom.urlsafe_base64

    if @answer_set.save!
      redirect_to results_path(@answer_set.uuid), notice: 'Your response was successfully created.'
    else
      redirect_to root_path, notice: 'Something went wrong'
    end
  end
end
