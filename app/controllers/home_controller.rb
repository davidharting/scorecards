class HomeController < ApplicationController
  def index
    @user = current_user
    @scorecards = @user.scorecards
  end

  def terms; end

  def privacy; end
end
