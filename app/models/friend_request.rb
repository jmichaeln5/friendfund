class FriendRequest < ApplicationRecord
  # after_update :check_friendship
  before_create :check_friendship

  enum status: { pending: 0, accepted: 1, rejected: 2, canceled: 3 } # Cancel option to be overwritten with soft delete

  belongs_to :requestor, class_name: :User
  belongs_to :receiver, class_name: :User

  validates_uniqueness_of :requestor_id, scope: [:receiver_id]

  private
  #
    def check_friendship

      byebug

      puts "Checking Friendship..."
      puts self.inspect


    end
end
