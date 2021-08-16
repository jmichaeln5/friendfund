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
      if @friend_request.accepted?

        friendship = Friendship.new(friend_a: @friend_request.receiver, friend_b: @friend_request.requestor)

        notify_requestor = Notification.new(recipient: @friend_request.requestor, actor: @friend_request.receiver, action:'accepted', notifiable: friendship )

        friendship.save
        notify_requestor.save

        destroy_old_notification = Notification.all.where(actor_id: @friend_request.requestor_id, recipient_id: @friend_request.receiver_id ,notifiable: @friend_request).first.destroy

        redirect_to user_friends_path(current_user), notice: "Friend request accepted. You are now friends with #{@friend_request.requestor.username}."
      else
        redirect_to request.referrer, notice: "friend request #{@friend_request.status}."
      end
    else
      redirect_to request.referrer
      @friend_request.errors.full_messages.each.map {|message| flash[:alert] = message }
    end
  end

  # DELETE /friend_requests/1 or /friend_requests/1.json
  def destroy
    @friend_request.destroy
    # redirect_to request.referrer, notice: "friend request #{@friend_request.status}."
    redirect_to request.referrer
    @friend_request.messages.full_messages.each.map {|message| flash[:alert] = message }
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
