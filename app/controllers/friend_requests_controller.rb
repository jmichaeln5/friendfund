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

    # POST /friend_requests or /friend_requests.json
    def create
      @friend_request = FriendRequest.new(friend_request_params)
      # params[:status].to_i

      respond_to do |format|
        if @friend_request.save
          format.html { redirect_to @friend_request, notice: "FriendRequest was successfully created." }
          format.json { render :show, status: :created, location: @friend_request }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @friend_request.errors, status: :unprocessable_entity }
        end
      end
    end


# ####### Admin Create (TEST PURPOSES ONLY!!!!)
    def admin_friend_request
      @friend_request = FriendRequest.new
    end

    def admin_create_friend_request
      @friend_request = FriendRequest.new(friend_request_params)
      respond_to do |format|
        if @friend_request.save
          format.html { redirect_to @friend_request, notice: "FriendRequest was successfully created." }
          format.json { render :show, status: :created, location: @friend_request }
        else

          # format.html { render :admin_friend_request, status: :unprocessable_entity }

          redirect_to admin_friend_request_path, flash: {error: "Now please fill in the questionnaire."}

          format.json { render json: @friend_request.errors, status: :unprocessable_entity }
        end
      end
    end
# ####### Admin Create (TEST PURPOSES ONLY!!!!)


  # PATCH/PUT /friend_requests/1 or /friend_requests/1.json
  def update

    # byebug
    respond_to do |format|
      if @friend_request.update(friend_request_params)
        format.html { redirect_to @friend_request, notice: "friend request #{@friend_request.status}" }
        format.json { render :show, status: :ok, location: @friend_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friend_requests/1 or /friend_requests/1.json
  def destroy
    @friend_request.destroy
    respond_to do |format|
      format.html { redirect_to friend_requests_url, notice: "FriendRequest was successfully destroyed." }
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
