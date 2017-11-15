# == Schema Information
#
# Table name: demographic_questions
#
#  id          :integer          not null, primary key
#  text        :text
#  position    :integer
#  short_name  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  optional    :boolean          default(FALSE)
#  description :text
#  published   :boolean          default(TRUE)
#

class DemographicQuestion < ApplicationRecord
end
