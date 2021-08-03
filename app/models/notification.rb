class Notification < ApplicationRecord
  before_create :verify_single_notification

  belongs_to :recipient, class_name: 'User'
  belongs_to :actor, class_name: 'User'
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read_at: nil) }

  private

  def verify_single_notification
    # byebug
  end

end
