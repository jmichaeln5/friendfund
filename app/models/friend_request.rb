class FriendRequest < ApplicationRecord
  enum status: { pending: 0, accepted: 1, rejected: 2, canceled: 3 } # Cancel option should trigger soft delete

  belongs_to :requestor, class_name: :User
  belongs_to :receiver, class_name: :User
  ############
  # has_many :users, through: :friend_requests
  # has_many :followers, :class_name => 'User', :through => :friendships, :foreign_key => 'friend_id'
  # has_and_belongs_to_many :users, class_name: :User, through: :friend_requests
  # has_one :actor, through: :notifications
  # has_one :recipient, through: :notifications
  # has_many :users, class_name: :User, through: self
  ############

  before_create :check_request_status
  before_create :check_if_friendship_exists
  before_create :check_if_request_exists
  before_destroy :yeet_notification
  after_update :handle_friend_request_cycle

  validates :status, presence: true
  validate :disallow_self_referential_friend_request

  def is_active?
    if (self.pending?) || (self.accepted?)
      return true
    else
      return false
    end
  end

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
      if Notification.all.where(actor_id: self.requestor_id, recipient_id:receiver_id).any?
        Notification.all.where(actor_id: self.requestor_id, recipient_id:receiver_id ).each do |notification|
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
    end

    def auto_mark_notification_as_read
      if Notification.all.where(actor_id: self.requestor_id, recipient_id:receiver_id).any?
        Notification.all.where(actor_id: self.requestor_id, recipient_id:receiver_id ).each do |notification|
          if (self == notification.notifiable) && (notification.read_at.present? == false )
            notification.update(read_at: Time.zone.now)
            puts " "
            puts "*"*50
            puts " *** Associated Notification marked as read at #{notification.read_at} *** "
            puts "*"*50
            puts " "
          else
            puts " "
            puts "*"*50
            puts " message from auto_mark_notification_as_read: "
            puts " ...nothing to do "
            puts "*"*50
            puts " "
          end
        end
      end
    end

    def handle_friend_request_cycle
      auto_mark_notification_as_read

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
      # self.destroy
      # puts "*"*50
      # puts " *** FriendRequest destroyed *** "
      # puts "*"*50
      # puts " "
    end








end
