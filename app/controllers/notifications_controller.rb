class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, only: [ :update, :show, :mark_as_read ]


  def index
    @notifications = current_user.notifications.where(recipient: current_user.id).unread
  end

  def all_notifications
    # @all_notifications = Notification.all
  end

  def mark_all_as_read
    @notifications = Notification.where(recipient: current_user).unread
    @notifications.update_all(read_at: Time.zone.now)
    redirect_to request.referrer, notice: "notifications marked as read."
  end

  def mark_as_read
    notification = @notification
    @notification.update(read_at: Time.zone.now)
    if @notification.save
      redirect_to request.referrer, notice: "notification marked as read."
    else
      redirect_to request.referrer
      @notification.errors.full_messages.each.map {|message| flash[:alert] = message }
    end
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end

  def notification_params
    params.require(:notification).permit(:actor_id, :recipient_id, :action, :read_at, :notifiable_type, :notifiable_id)
  end

end
