class MakeCheckboxQuestionsRequired < ActiveRecord::Migration[5.0]
  def change
    DemographicQuestion.find_by_short_name("conservation_sectors")&.update_attributes(optional: false)
    DemographicQuestion.find_by_short_name("non_conservation_sectors")&.update_attributes(optional: false)
    DemographicQuestion.find_by_short_name("value_shaping_items")&.update_attributes(optional: false)
  end
end
