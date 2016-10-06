class CreateAnswerSets < ActiveRecord::Migration[5.0]
  def change
    create_table :answer_sets do |t|
      t.string :ip_address
      t.jsonb :answers
      t.float :x_axis_total
      t.float :y_axis_total

      t.timestamps
    end
  end
end
