class FriendRequest < ApplicationRecord
  enum status: { pending: 0, accepted: 1, rejected: 2, canceled: 3 } # Cancel & Rejected option should trigger soft delete

  belongs_to :requestor, class_name: :User
  belongs_to :receiver, class_name: :User

  has_many :notifications

  validates :status, presence: true
  validate :disallow_self_referential_friend_request

  before_create :check_if_friendship_exists, :check_if_request_exists, :check_request_status
  before_update :check_if_friendship_exists, :check_request_status, :handle_notification
  after_update :handle_friend_request_cycle
  before_destroy :yeet_notification

  private

    def disallow_self_referential_friend_request
      if (requestor_id == receiver_id)
        errors.add(:base, "Invalid Action.")
      end
    end

    def check_if_request_exists
      if ( (self.class.all.where(requestor_id: self.receiver_id, receiver_id: self.requestor_id ).any?) ==  true ) || ( (self.class.all.where(requestor_id: self.requestor_id, receiver_id: self.receiver_id ).any?) ==  true )
        self.errors.add(:base, "Invalid Action, Friend Request already exists.")
        throw(:abort)
      end
    end

    def check_if_friendship_exists
      if ( (Friendship.all.where(friend_a_id: self.receiver_id, friend_b_id: self.requestor_id ).any?) ==  true ) || ( (Friendship.all.where(friend_a_id: self.requestor_id, friend_b_id: self.receiver_id ).any?) ==  true )
        self.errors.add(:base, "Invalid Action, users are already friends.")
        throw(:abort)
      end
    end

    def check_request_status
      puts "Checking FriendRequest..."
      puts self.inspect
      if self.status == nil
        self.status = "pending"
      end
    end

    def yeet_notification
      if  Notification.all.where(notifiable_id: self.id).first.present?
        notification =  Notification.all.where(notifiable_id: self.id).first
        puts "Notification == FriendRequest? #{self == notification.notifiable}"
        if self == notification.notifiable
          notification.destroy
          puts " "
          puts "*"*50
          puts "Associated Notification Destroyed"
          puts "*"*50
          puts " "
        end
      end
    end

    def handle_notification
      if Notification.all.where(notifiable_id: self.id).first.present?
          notification = Notification.all.where(notifiable_id: self.id).first
          if (self.status == 'canceled') || (self.status == 'rejected')
            yeet_notification
          else
            mark_notification_as_read
          end
      end
    end

    def mark_notification_as_read
      notification =  Notification.all.where(notifiable_id: self.id).first
      if notification.read_at.present? == false
        notification.update(read_at: Time.zone.now)
        puts " "
        puts "*"*50
        puts " *** Associated Notification marked as read at #{notification.read_at} *** "
        puts "*"*50
        puts " "
      else
        puts " "
        puts "*"*50
        puts " message from mark_notification_as_read: #{notification.read_at}"
        puts " ...nothing to do "
        puts "*"*50
        puts " "
      end
    end

    def handle_friend_request_cycle
      case self.status
      when 'accepted'
          puts " "
          puts "*"*50
          puts " *** FriendRequest Accepted *** "
          puts "*"*50
          puts " "
          # friendship = Friendship.create(friend_a_id: self.receiver_id, friend_b_id: self.requestor_id)
          puts " "
          puts "*"*50
          puts " *** Friendship created between (friend a)#{self.receiver.name} and (friend b)#{self.requestor.name} *** "
          puts "*"*50
          puts " "
        when 'rejected'
          # byebug
          puts " "
          puts "*"*50
          puts " *** FriendRequest rejected *** "
          puts "*"*50
          puts " "
        when 'canceled'
          # byebug
          puts " "
          puts "*"*50
          puts " *** FriendRequest canceled *** "
          puts "*"*50
          puts " "
      end
      self.destroy
      puts "*"*50
      puts " *** FriendRequest destroyed *** "
      puts "*"*50
      puts " "
    end








end
