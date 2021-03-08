class HomeController < ApplicationController
  def index
    @user = current_user
    @scorecards = @user.nil? ? [] : @user.scorecards.order(created_at: :desc)
  end

  def terms; end

  def privacy; end
end
