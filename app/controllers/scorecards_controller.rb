class ScorecardsController < ApplicationController
  before_action :authenticate_user!

  def new
    @scorecard = Scorecard.new
    @name_class = 'form-control'
  end

  def create
    @scorecard = current_user.scorecards.new(scorecard_params)
    @name_class = 'form-control'
    Rails.logger.info('Created scorecard')
    if @scorecard.save
      Rails.logger.info('Save successful')

      flash[:notice] = 'Successfully created scorecard'
      redirect_to root_path
    else
      Rails.logger.info('Failed to save')
      Rails.logger.error(@scorecard.errors.has_key?(:name))
      Rails.logger.error(@scorecard.errors.full_messages_for(:name))
      @name_class = 'form-control is-invalid'
      flash[:alert] = 'Failed to create scorecard.'
      render :new
    end
  end

  private

  def scorecard_params
    params.require(:scorecard).permit(:name)
  end
end
