class FriendRequest < ApplicationRecord
  enum status: { pending: 0, accepted: 1, rejected: 2, canceled: 3 } # Cancel option to be overwritten with soft delete
  before_create :check_request_receiver

  # ### Both check_request_status && check_request_actor work inconsistently
  before_save :check_request_status
  before_save :check_request_actor

  belongs_to :requestor, class_name: :User
  belongs_to :receiver, class_name: :User

  validate :disallow_self_referential_friendship

  def check_request_actor
    if (self.class.all.where(requestor_id: self.receiver_id, receiver_id: self.requestor_id ).any?) ==  true
      self.errors.add(:base, "Invalid Action, Friend Request already exists.")
      throw(:abort)
    end
  end

  def check_request_receiver
    if (self.class.all.where(receiver_id: self.requestor_id, requestor_id: self.receiver_id ).any? )  ==  true
      self.errors.add(:base, "Invalid Action, Friend Request already exists.")
      throw(:abort)
    end
  end

  private

    def disallow_self_referential_friendship
      if (requestor_id == receiver_id)
        errors.add(:base, "Invalid Action.")
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
