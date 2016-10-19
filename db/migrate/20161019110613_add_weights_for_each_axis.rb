class AddWeightsForEachAxis < ActiveRecord::Migration[5.0]
  def change
    rename_column :questions, :weight, :x_weight
    add_column :questions, :y_weight, :float
    remove_column :questions, :axis
  end
end
