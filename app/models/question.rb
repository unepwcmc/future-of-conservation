# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :text
#  x_weight   :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  y_weight   :float
#  short_name :string
#

class Question < ApplicationRecord
  has_paper_trail

  translates :text
  #accepts_nested_attributes_for :translations
  #attr_accessor :translations_attributes

  validates_numericality_of :x_weight, :y_weight,
    greater_than_or_equal_to: -4.0,
    less_than_or_equal_to: 4.0,
    message: "Weighting must be a decimal value between -4.0 and 4.0"
end

