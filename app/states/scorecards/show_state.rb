module Scorecards
  class ShowState
    def initialize(user:, scorecard_id:)
      puts("!!!!!!!!!!!!!\n\n#{user}")
      puts "initialize state #{scorecard_id} "
      @scorecard = user.scorecards.find(scorecard_id)
      @players = Scorecards.ordered_players(@scorecard)
      @rounds = @scorecard.rounds.order(number: :asc)
    end

    attr_reader :scorecard
    attr_reader :players
    attr_reader :rounds
  end
end
