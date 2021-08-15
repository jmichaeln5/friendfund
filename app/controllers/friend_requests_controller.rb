class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friend_request, only: %i[ show update destroy ]

  # GET /friend_requests or /friend_requests.json
  def index
    @friend_requests = FriendRequest.all.order("created_at DESC")
    @recieved_friend_requests = FriendRequest.all.where(receiver_id: current_user.id).order("created_at DESC")
  end

  # GET /friend_requests/1 or /friend_requests/1.json
  def show
    @friend_request = FriendRequest.find(params[:id])
    friend_request = FriendRequest.find(params[:id])
  end

  # GET /friend_requests/new
  def new
    @friend_request = FriendRequest.new
    friend_request = FriendRequest.new
  end

  def create
    @friend_request = FriendRequest.new(friend_request_params)
    if @friend_request.save

      Notification.create(recipient: @friend_request.receiver, actor: @friend_request.requestor, action:'requested', notifiable: @friend_request )

      redirect_to request.referrer, notice: "friend request sent."
    else
      redirect_to request.referrer
      @friend_request.errors.full_messages.each.map {|message| flash[:alert] = message }
    end
  end

  # PATCH/PUT /friend_requests/1 or /friend_requests/1.json
  def update
      if @friend_request.update(friend_request_params)
      redirect_to request.referrer, notice: "friend request #{@friend_request.status}."
    else
      redirect_to request.referrer
      @friend_request.errors.full_messages.each.map {|message| flash[:alert] = message }
    end
  end

  # DELETE /friend_requests/1 or /friend_requests/1.json
  def destroy
    @friend_request.destroy
    respond_to do |format|
      format.html { redirect_to user_friend_requests_path(current_user), notice: "friend request removed." }
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
