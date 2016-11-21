class DemographicQuestionsController < ApplicationController
  before_action :set_demographic_question, only: [:show, :edit, :update, :destroy]

  # GET /demographic_questions
  # GET /demographic_questions.json
  def index
    @demographic_questions = DemographicQuestion.all
  end

  # GET /demographic_questions/1
  # GET /demographic_questions/1.json
  def show
  end

  # GET /demographic_questions/new
  def new
    @demographic_question = DemographicQuestion.new
  end

  # GET /demographic_questions/1/edit
  def edit
  end

  # POST /demographic_questions
  # POST /demographic_questions.json
  def create
    @demographic_question = DemographicQuestion.new(demographic_question_params)

    respond_to do |format|
      if @demographic_question.save
        format.html { redirect_to @demographic_question, notice: 'Demographic question was successfully created.' }
        format.json { render :show, status: :created, location: @demographic_question }
      else
        format.html { render :new }
        format.json { render json: @demographic_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /demographic_questions/1
  # PATCH/PUT /demographic_questions/1.json
  def update
    respond_to do |format|
      if @demographic_question.update(demographic_question_params)
        format.html { redirect_to @demographic_question, notice: 'Demographic question was successfully updated.' }
        format.json { render :show, status: :ok, location: @demographic_question }
      else
        format.html { render :edit }
        format.json { render json: @demographic_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /demographic_questions/1
  # DELETE /demographic_questions/1.json
  def destroy
    @demographic_question.destroy
    respond_to do |format|
      format.html { redirect_to demographic_questions_url, notice: 'Demographic question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_demographic_question
      @demographic_question = DemographicQuestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def demographic_question_params
      params.require(:demographic_question).permit(:text, :position, :short_name)
    end
end
