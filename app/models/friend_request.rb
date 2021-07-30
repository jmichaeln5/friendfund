class FriendRequest < ApplicationRecord
  before_create :check_request_status

  enum status: { pending: 0, accepted: 1, rejected: 2, canceled: 3 } # Cancel option to be overwritten with soft delete

  belongs_to :requestor, class_name: :User
  belongs_to :receiver, class_name: :User

  validates_uniqueness_of :requestor_id, scope: [:receiver_id], message: "of Message: Cannot add friend, Request already exists!"
  validates_uniqueness_of :receiver_id, scope: [:requestor_id], message: "of Message: Cannot add friend, Request already exists!"

  private

    def check_request_status
      puts "Checking FriendRequest..."
      puts self.inspect
      if self.status == nil
        self.status = "pending"
      end
    end
end
