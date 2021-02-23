class Scorecard < ApplicationRecord
  belongs_to :user

  validates :name, length: { minimum: 1, maximum: 280 }
end
