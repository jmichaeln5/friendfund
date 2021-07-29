class UsersController < ApplicationController

  # GET /users or /users.json
  def index
    @users = User.all.order("created_at ASC")
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    @requested_by_current_user = @user.friend_requests_as_receiver.where(requestor_id: current_user.id)

  end


end
