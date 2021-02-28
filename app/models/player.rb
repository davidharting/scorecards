class Player < ApplicationRecord
  belongs_to :scorecard

  validates :name, presence: true
  validates :name, length: { minimum: 1, maximum: 60 }
end
