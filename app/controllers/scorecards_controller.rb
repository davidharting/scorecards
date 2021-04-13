class ScorecardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @state =
      Scorecards::ShowState.new(user: current_user, scorecard_id: params[:id])
  end

  def new
    @scorecard = Scorecard.new
    4.times { @scorecard.players.build }
  end

  def create
    @scorecard = current_user.scorecards.new(scorecard_params)
    @scorecard.players.each { |p| p.destroy if p.name.nil? or p.name.empty? }

    if @scorecard.save
      flash[:notice] = 'Successfully created scorecard'
      redirect_to root_path
    else
      flash[:alert] = 'Failed to create scorecard.'
      render :new
    end
  end

  private

  def ordered_players(scorecard)
    scorecard.players.order(id: :asc)
  end

  def scorecard_params
    params.require(:scorecard).permit(:name, players_attributes: [:name])
  end
end
