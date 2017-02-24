class ResultsController < ApplicationController
  before_action :authenticate, only: [:index]

  def index
    @results = AnswerSet.all

    respond_to do |format|
      format.html
      format.csv { send_data CsvExporter.export_results(@results), filename: "results-#{Date.today}.csv" }
    end
  end

  def show
    @results = AnswerSet.find_by(uuid: params[:uuid])
    @all_other_results = AnswerSet.all.reject{ |r| r.id == @results.id }.pluck(:x_axis_scaled, :y_axis_scaled)

    if params["filter"].present?
      if params["filter"]["gender"].present?
        @all_other_results = AnswerSet.results_by_field("gender", params["filter"]["gender"], @results.id)
      elsif params["filter"]["educational_specialism"].present?
        @all_other_results = AnswerSet.results_by_field("educational_specialism", params["filter"]["educational_specialism"], @results.id)
      elsif params["filter"]["education"].present?
        @all_other_results = AnswerSet.results_by_field("education", params["filter"]["education"], @results.id)
      elsif params["filter"]["age"].present?
        min = params["filter"]["age"]["min"] || 0
        max = params["filter"]["age"]["max"] || 99
        @all_other_results = AnswerSet.results_by_age(min, max, @results.id)
      end
    end

    @data = [
      { name: "Other people's results", data: @all_other_results },
      { name: "Your results", data: [[@results.x_axis_scaled, @results.y_axis_scaled]] }
    ]
    @config = CHARTKICK_CONFIG
  end

  def export
    CsvExporterJob.perform_later(AnswerSet.all)
    redirect_to results_path, notice: "Your CSV is being generated, we will send an email to #{Rails.application.secret.notification_email} when it is ready to download"
  end
end
