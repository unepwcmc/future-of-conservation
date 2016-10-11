class AddScaledAxisToAnswerSet < ActiveRecord::Migration[5.0]
  def change
    add_column :answer_sets, :x_axis_scaled, :float
    add_column :answer_sets, :y_axis_scaled, :float
  end
end
