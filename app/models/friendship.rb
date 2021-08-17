class Friendship < ApplicationRecord
  belongs_to :friend_a, class_name: :User
  belongs_to :friend_b, class_name: :User

  before_create :create_friendship_notification

  private

  def create_friendship_notification
    # byebug

    # Notification.create(actor_id: self.friend_b.id, recipient_id:friend_a.id, action:'accepted', notifiable: self )
    # Notification.create(actor_id: self.friend_b_id, recipient_id:friend_a)
  end
end
