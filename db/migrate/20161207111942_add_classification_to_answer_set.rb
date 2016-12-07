class AddClassificationToAnswerSet < ActiveRecord::Migration[5.0]
  def change
    add_reference :answer_sets, :classification, index: true
  end
end
