class Scorecard < ApplicationRecord
  belongs_to :user
  has_many :players
  validates :name, length: { minimum: 1, maximum: 280 }
end
