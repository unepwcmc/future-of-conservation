class ResultsController < ApplicationController
  def show
    @results = AnswerSet.find_by(uuid: params[:uuid])
    @all_other_results = AnswerSet.pluck(:x_axis_scaled, :y_axis_scaled)

    if params["filter"].present?
      if params["filter"]["gender"].present?
        @all_other_results = AnswerSet.where("answers->'demographics'->>'gender' = ?", params["filter"]["gender"]
                             ).pluck(:x_axis_scaled, :y_axis_scaled)
      end

      if params["filter"]["age"].present?
      end
    end

    @data = [ { name: "Other peoples results", data: @all_other_results },
              { name: "Your results", data: [[@results.x_axis_scaled, @results.y_axis_scaled]] } ]
    @config = { library:
                {
                  hAxis: {minValue: -1, maxValue: 1}, vAxis: {minValue: -1, maxValue: 1},
                  legend: {position: 'bottom'}
                }
              }
  end
end
