class AddTranslationTableForQuestions < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      dir.up do
        Question.create_translation_table! :text => :text
      end

      dir.down do
        Question.drop_translation_table!
      end
    end
  end
end
