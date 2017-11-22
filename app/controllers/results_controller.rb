class ResultsController < ApplicationController
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
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
    to_email = params[:to_email]
    from_date = params[:from_date]
    to_date = params[:to_date]
    default_notification_email = Rails.application.secrets.notification_email

    to_email = to_email.empty? || !email_valid?(to_email) ? default_notification_email : to_email
    from_date = from_date.empty? || !date_valid?(from_date) ? "2016-01-01" : from_date
    to_date = to_date.empty? || !date_valid?(to_date) ? Date.today.to_s : to_date

    CsvExporterJob.perform_later(to_email, from_date, to_date)
    redirect_to root_path, notice: "Your CSV is being generated, we will send an email to #{to_email} when it is ready to download"
  end

  private

  def date_valid?(date)
    begin
      year, month, day = date&.split("-").map(&:to_i)
      return Date.valid_date?(year, month, day)
    rescue
      return false
    end
  end

  def email_valid?(email)
    EMAIL_REGEX.match email
  end

end
