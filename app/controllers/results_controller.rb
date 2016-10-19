class ResultsController < ApplicationController
  def show
    @results = AnswerSet.find_by(uuid: params[:uuid])
    @config = { library:
                {
                  hAxis: {minValue: -1, maxValue: 1}, vAxis: {minValue: -1, maxValue: 1},
                  legend: {position: 'bottom'}
                }
              }
    @data = [ { name: "Other peoples results", data: AnswerSet.pluck(:x_axis_scaled, :y_axis_scaled) },
              { name: "Your results", data: [[@results.x_axis_scaled, @results.y_axis_scaled]] } ]
  end
end
