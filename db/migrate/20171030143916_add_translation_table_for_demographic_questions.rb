class AddTranslationTableForDemographicQuestions < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      dir.up do
        DemographicQuestion.create_translation_table! :text => :text, :description => :text
      end

      dir.down do
        DemographicQuestion.drop_translation_table!
      end
    end
  end
end
