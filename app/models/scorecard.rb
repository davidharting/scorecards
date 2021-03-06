class Scorecard < ApplicationRecord
  belongs_to :user
  has_many :players
  has_many :rounds

  validates :name, length: { minimum: 1, maximum: 280 }

  accepts_nested_attributes_for :players
end
