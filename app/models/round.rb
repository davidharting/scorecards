class Round < ApplicationRecord
  belongs_to :scorecard
  belongs_to :player
end
