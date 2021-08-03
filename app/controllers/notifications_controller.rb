class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    # @notifications = Notification.where(recipient: current_user.id).unread
    @notifications = current_user.notifications.where(recipient: current_user.id).unread
  end

  def mark_as_read
    @notifications = Notification.where(recipient: current_user).unread
    @notifications.update_all(read_at: Time.zone.now)

    redirect_to request.referrer, notice: "notifications marked as read."

  end
end
