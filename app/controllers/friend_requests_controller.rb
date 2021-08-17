class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friend_request, only: %i[ show update destroy ]

  # GET /friend_requests or /friend_requests.json
  def index
    @all_friend_requests = FriendRequest.all.order("created_at DESC")
    @friend_requests_as_receiver = FriendRequest.all.where(receiver: current_user).order("created_at DESC")
    @friend_requests_as_requestor = FriendRequest.all.where(requestor: current_user).order("created_at DESC")
    # @friend_requests_as_receiver = current_user.friend_requests_as_receiver
    # @friend_requests_as_requestor = current_user.friend_requests_as_requestor
    @friend_requests = current_user.friend_requests.order("created_at DESC")
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
      if @friend_request.accepted?
        friendship = Friendship.new(friend_a: @friend_request.receiver, friend_b: @friend_request.requestor)

        notify_requestor = Notification.new(recipient: @friend_request.requestor, actor: @friend_request.receiver, action:'accepted', notifiable: friendship )

        friendship.save
        notify_requestor.save
        redirect_to (dashboard_path), notice: "friend request accepted. You are now friends with #{@friend_request.requestor.username}."

      elsif @friend_request.rejected?
        redirect_to (dashboard_path), notice: "friend request rejected."
      else
        redirect_to (dashboard_path)
        @friend_request.errors.full_messages.each.map {|message| flash[:alert] = message }
      end
    end
  end

  # DELETE /friend_requests/1 or /friend_requests/1.json
  def destroy
    @friend_request.destroy
    redirect_to request.referrer, notice: "friend request deleted"
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
