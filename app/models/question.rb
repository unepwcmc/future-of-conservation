# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :text
#  weight     :float
#  axis       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ApplicationRecord
  has_paper_trail

  validates_numericality_of :weight,
    greater_than_or_equal_to: -4,
    less_than_or_equal_to: 4,
    message: "Weighting must be a decimal value between -4 and +4"
end
