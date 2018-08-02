# == Schema Information
#
# Table name: classifications
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Classification < ApplicationRecord
  has_many :answer_sets
  translates :name, :description, :results_description
end
