class AddStrengthToAnswerSet < ActiveRecord::Migration[5.0]
  def change
    add_column :answer_sets, :classification_strength, :string
  end
end
