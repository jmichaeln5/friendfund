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
  before_create :check_if_request_exists
  before_destroy :yeet_notification

  validates :status, presence: true
  validate :disallow_self_referential_friendship

  def check_request_receiver
    puts "*"*100
    puts " *** Checking Reqeust Actor *** "*100
    puts "*"*100
    if (self.class.all.where(receiver_id: self.requestor_id, requestor_id: self.receiver_id ).any? )  ==  true
      self.errors.add(:base, "Invalid Action, Friend Request already exists.")
      throw(:abort)
    end
  end

  def yeet_notification
    if Notification.all.where(actor_id: self.requestor_id, recipient_id:receiver_id).any?
      Notification.all.where(actor_id: self.requestor_id, recipient_id:receiver_id ).each do |notification|
        puts "Notification == FriendRequest? #{self == notification.notifiable}"
        if self == notification.notifiable
          notification.destroy
          puts "*"*50
          puts "Associated Notification Destroyed"
          puts "*"*50
        end
      end
    end
  end

  private

    def disallow_self_referential_friendship
      if (requestor_id == receiver_id)
        errors.add(:base, "Invalid Action.")
      end
    end


    def check_if_request_exists
      if (self.class.all.where(requestor_id: self.requestor_id, receiver_id: self.receiver_id ).any?) ==  true
        self.errors.add(:base, "Invalid Action, Friend Request already exists.")
        throw(:abort)
      end

      if (self.class.all.where(requestor_id: self.receiver_id, receiver_id: self.requestor_id ).any?) ==  true
        self.errors.add(:base, "Invalid Action, Friend Request already exists.")
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
end
