class ResultsController < ApplicationController
  before_action :authenticate, only: [:index]

  def index
    @results = AnswerSet.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @results = AnswerSet.find_by(uuid: params[:uuid])
    @all_other_results = AnswerSet.last(1000).reject{ |r| r.id == @results.id }.pluck(:x_axis_scaled, :y_axis_scaled)

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
    to_email  = params[:to_email].presence || Rails.application.secrets.notification_email
    from_date = params[:from_date]
    to_date   = params[:to_date]

    CsvExporterJob.perform_later(to_email, from_date, to_date)
    redirect_to root_path, notice: "Your CSV is being generated, we will send an email to #{to_email} when it is ready to download"
  end
end
