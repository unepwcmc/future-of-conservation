class AddOptionsToDemographicQuestions < ActiveRecord::Migration[5.0]
  def change
    DemographicQuestion.find_by_short_name("age")&.update_attributes(optional: true)
    DemographicQuestion.find_by_short_name("country")&.update_attributes(optional: true)
    DemographicQuestion.find_by_short_name("location_of_work")&.update_attributes(optional: true)
    DemographicQuestion.find_by_short_name("total_countries_worked_in")&.update_attributes(optional: true)
    DemographicQuestion.find_by_short_name("conservation_sectors")&.update_attributes(optional: true)
    DemographicQuestion.find_by_short_name("non_conservation_sectors")&.update_attributes(optional: true)
    DemographicQuestion.find_by_short_name("value_shaping_items")&.update_attributes(optional: true)
    DemographicQuestion.find_by_short_name("shaping_values")&.update_attributes(optional: true)
    DemographicQuestion.find_by_short_name("email")&.update_attributes(optional: true)
  end
end
