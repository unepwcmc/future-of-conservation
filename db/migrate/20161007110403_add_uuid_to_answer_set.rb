class AddUuidToAnswerSet < ActiveRecord::Migration[5.0]
  def change
    add_column :answer_sets, :uuid, :string
  end
end
