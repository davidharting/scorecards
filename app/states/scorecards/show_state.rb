module Scorecards
  class ShowState
    def initialize(user:, scorecard_id:)
      @scorecard =
        user.scorecards.includes(:rounds, players: [:scores]).find(scorecard_id)
    end

    attr_reader :scorecard

    def sums_ordered_by_player_id
      ordered_players.map do |player|
        score_values = player.scores.map { |score| score.value }
        score_values.reduce(:+)
      end
    end

    def ordered_players
      scorecard.players.sort { |p1, p2| p1.id - p2.id }
    end

    def lookup_score(player_id:, round_id:)
      scorecard.players.find do |player|
        if player.id == player_id
          score = player.scores.find { |score| score.round_id == round_id }
          return score
        end
      end
      return nil
    end
  end
end
