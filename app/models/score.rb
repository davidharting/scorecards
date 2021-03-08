class Score < ApplicationRecord
  belongs_to :round
  belongs_to :player

  validates :value, presence: true
end
