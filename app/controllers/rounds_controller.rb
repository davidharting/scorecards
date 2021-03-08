class RoundsController < ApplicationController
  def new
    @scorecard = get_scorecard
    @players = ordered_players(@scorecard)
    @round = @scorecard.rounds.new(number: next_round_number)
    @players.each { |p| @round.scores.build(player_id: p.id) }
  end

  def create
    @scorecard = get_scorecard
    @players = ordered_players(@scorecard)

    @round = @scorecard.rounds.new(number: next_round_number)

    payload = round_params

    @players.each_with_index do |p, i|
      @round.scores.new(
        {
          player_id: p.id,
          value: payload.dig(:scores_attributes, i.to_s.to_sym, :value),
        },
      )
    end

    if @round.save
      flash[:notice] = 'Successfully recorded round of scores'
      redirect_to @scorecard
    else
      flash[:alert] = 'Failed to record scores'
      render :new
    end
  end

  private

  def get_scorecard
    current_user.scorecards.find(params[:scorecard_id])
  end

  def ordered_players(scorecard)
    scorecard.players.order(id: :asc)
  end

  def round_params
    params.require(:round).permit(scores_attributes: [:value])
  end

  def next_round_number
    @scorecard.rounds.empty? ? 1 : @scorecard.rounds.maximum('number') + 1
  end
end
