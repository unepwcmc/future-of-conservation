class ChangeClassificationStrengthOnAnswerSets < ActiveRecord::Migration[5.0]
  def change
    add_column :answer_sets, :classification_strength_x, :string
    add_column :answer_sets, :classification_strength_y, :string
    remove_column :answer_sets, :classification_strength
  end
end
