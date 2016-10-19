class ResultsController < ApplicationController
  def show
    @results = AnswerSet.find_by(uuid: params[:uuid])
    @config = { library:
                {
                  hAxis: {minValue: -3, maxValue: 3}, vAxis: {minValue: -3, maxValue: 3},
                  legend: {position: 'bottom'}
                }
              }
    @data = [ { name: "Other peoples results", data: AnswerSet.pluck(:x_axis_scaled, :y_axis_scaled) },
              { name: "Your results", data: [[@results.x_axis_scaled, @results.y_axis_scaled]] } ]
  end
end
