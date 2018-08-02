class AddLanguageToAnswerSet < ActiveRecord::Migration[5.0]
  def change
    add_column :answer_sets, :language, :string
  end
end
