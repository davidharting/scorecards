class Round < ApplicationRecord
  belongs_to :scorecard
  has_many :scores

  accepts_nested_attributes_for :scores
end
