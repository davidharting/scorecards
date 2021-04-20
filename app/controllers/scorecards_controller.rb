class ScorecardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @state =
      Scorecards::ShowState.new(user: current_user, scorecard_id: params[:id])
  end

  def new
    @scorecard = Scorecard.new
    @scorecard.players.build
  end

  def create
    @scorecard = current_user.scorecards.new(scorecard_params)
    if add_player?
      @scorecard.players.build
      render :new
    elsif remove_player?
      players = @scorecard.players.to_a
      @scorecard.players.delete_all

      player_to_remove_index = remove_player?
      players.delete_at(player_to_remove_index)

      players.each { |player| @scorecard.players.build(player.as_json) }

      render :new
    else
      @scorecard.players.each { |p| p.destroy if p.name.nil? or p.name.empty? }

      if @scorecard.save
        flash[:notice] = 'Successfully created scorecard'
        redirect_to root_path
      else
        flash[:alert] = 'Failed to create scorecard.'
        render :new
      end
    end
  end

  private

  def scorecard_params
    params.require(:scorecard).permit(:name, players_attributes: [:name])
  end

  def add_player?
    btn_value = params[:button]
    btn_value == 'add_player' ? true : false
  end

  def remove_player?
    btn_value = params[:button]
    if btn_value.start_with?('remove_player=')
      split = btn_value.split '='
      split[1].to_i
    else
      false
    end
  end
end
