class ScorecardsController < ApplicationController
  before_action :authenticate_user!

  def new
    @scorecard = Scorecard.new
    @name_class = 'form-control'
  end

  def create
    @scorecard = current_user.scorecards.new(scorecard_params)
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
    params.require(:scorecard).permit(:name)
  end
end
