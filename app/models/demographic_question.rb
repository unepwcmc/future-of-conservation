# == Schema Information
#
# Table name: demographic_questions
#
#  id         :integer          not null, primary key
#  position   :integer
#  short_name :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  optional   :boolean          default(FALSE)
#  published  :boolean          default(TRUE)
#

class DemographicQuestion < ApplicationRecord
  translates :text, :description
end
