class ScorecardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @scorecard = current_user.scorecards.find(params[:id])
    @players = @scorecard.players
  end

  def new
    @scorecard = Scorecard.new
    4.times { @scorecard.players.build }
  end

  def create
    @scorecard = current_user.scorecards.new(scorecard_params)
    @scorecard.players.each { |p| p.destroy if p.name.nil? or p.name.empty? }

    # binding.irb
    if @scorecard.save
      flash[:notice] = 'Successfully created scorecard'
      redirect_to root_path
    else
      flash[:alert] = 'Failed to create scorecard.'
      render :new
    end
  end

  private

  def scorecard_params
    params.require(:scorecard).permit(:name, players_attributes: [:name])
  end
end
