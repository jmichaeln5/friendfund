class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friend_request, only: %i[ show edit update destroy ]

  # GET /friend_requests or /friend_requests.json
  def index
    @friend_requests = FriendRequest.all.order("created_at DESC")
  end

  # GET /friend_requests/1 or /friend_requests/1.json
  def show
  end

  # GET /friend_requests/new
  def new
    @friend_request = FriendRequest.new
  end

  # GET /friend_requests/1/edit
  def edit
  end

  def create
    @friend_request = FriendRequest.new(friend_request_params)
    if @friend_request.save
      redirect_to request.referrer, notice: "FriendRequest was successfully created."
    else
      redirect_to request.referrer
      @friend_request.errors.full_messages.each.map {|message| flash[:alert] = message }
    end

  end

  # ####### Admin Create (TEST PURPOSES ONLY!!!!)
  def admin_friend_request
    @friend_request = FriendRequest.new
  end

  # PATCH/PUT /friend_requests/1 or /friend_requests/1.json
  def update
      if @friend_request.update(friend_request_params)
      redirect_to request.referrer, notice: "FriendRequest was successfully updated."
    else
      redirect_to request.referrer
      @friend_request.errors.full_messages.each.map {|message| flash[:alert] = message }
    end
  end

  # DELETE /friend_requests/1 or /friend_requests/1.json
  def destroy
    @friend_request.destroy
    respond_to do |format|
      format.html { redirect_to user_friend_requests_path(current_user), notice: "FriendRequest was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend_request
      @friend_request = FriendRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friend_request_params
      params.require(:friend_request).permit(:requestor_id, :receiver_id, :status)
    end

end
