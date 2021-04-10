module Scorecards
  def self.ordered_players(scorecard)
    scorecard.players.order(id: :asc)
  end
end
