class CreateDemographicQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :demographic_questions do |t|
      t.text :text
      t.integer :position
      t.string :short_name

      t.timestamps
    end
  end
end
