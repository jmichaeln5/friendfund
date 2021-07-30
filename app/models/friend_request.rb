class FriendRequest < ApplicationRecord
  before_create :check_request_status

  enum status: { pending: 0, accepted: 1, rejected: 2, canceled: 3 } # Cancel option to be overwritten with soft delete

  belongs_to :requestor, class_name: :User
  belongs_to :receiver, class_name: :User

  validate :disallow_self_referential_friendship
  validate :disallow_existing_request

  private

    def disallow_existing_request
      if self.class.where(requestor_id: requestor_id, receiver_id: receiver_id).or(self.class.where(requestor_id: receiver_id, receiver_id: requestor_id)).exists?
      errors.add(:base, 'Invalid Action.')
      end
    end

    def disallow_self_referential_friendship
      if requestor_id == receiver_id
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
