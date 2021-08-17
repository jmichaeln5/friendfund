class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friendship, only: %i[ show update destroy ]

  # GET /friendships or /friendships.json
  def index
    # @friendships = Friendship.all.order("created_at DESC")
    # @friendships = (current_user.friendships_as_friend_b) + (current_user.friendships_as_friend_a).all.order("created_at DESC")
    # @friends = @friendships
    @friendships = current_user.friendships.order("created_at DESC")
    # byebug
  end

  # GET /friendships/1 or /friendships/1.json
  def show
    @friendship = Friendship.find(params[:id])
    friendship = Friendship.find(params[:id])
  end

  def create
    @friendship = Friendship.new(friendship_params)
    if @friendship.save

      Notification.create(recipient: @friendship.receiver, actor: @friendship.requestor, action:'requested', notifiable: @friendship )

      redirect_to request.referrer, notice: "friend request sent."
    else
      redirect_to request.referrer
      @friendship.errors.full_messages.each.map {|message| flash[:alert] = message }
    end
  end

  # PATCH/PUT /friendships/1 or /friendships/1.json
  def update
    if @friendship.update(friendship_params)
      redirect_to request.referrer, notice: "friendship #{@friendship.status}."
    else
      redirect_to request.referrer
      @friendship.errors.full_messages.each.map {|message| flash[:alert] = message }
    end
  end

  # DELETE /friendships/1 or /friendships/1.json
  def destroy
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to user_friendships_path(current_user), notice: "friend request removed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friendship_params
      params.require(:friendship).permit(:requestor_id, :receiver_id, :status)
    end

end
