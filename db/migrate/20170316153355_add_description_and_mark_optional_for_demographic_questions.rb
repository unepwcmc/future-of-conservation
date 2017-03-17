class AddDescriptionAndMarkOptionalForDemographicQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :demographic_questions, :optional, :boolean, default: false
    add_column :demographic_questions, :description, :text
  end
end
