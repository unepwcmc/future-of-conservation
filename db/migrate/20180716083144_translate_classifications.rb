class TranslateClassifications < ActiveRecord::Migration[5.0]
  def up
    I18n.with_locale(:en) do
      Classification.create_translation_table!({
        name: :string,
        description: :text,
        results_description: :text
      }, {migrate_data: true})
    end
  end

  def down
    Classification.drop_translation_table! migrate_date: true
  end
end
