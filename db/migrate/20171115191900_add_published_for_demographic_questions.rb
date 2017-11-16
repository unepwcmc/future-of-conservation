class AddPublishedForDemographicQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :demographic_questions, :published, :boolean, default: true
  end
end
