class DashboardController < ApplicationController
  before_action :authenticate_user!

  #  # http://tutorials.jumpstartlab.com/topics/models/facade_pattern.html
  # Keep Controller Skinny!! By creating a new class for Dashboard in Models

  def show
    @user = current_user
    @dashboard = Dashboard.new
  end
end
