class FriendRequest < ApplicationRecord
  # after_update :check_friendship

  enum status: { pending: 0, accepted: 1, rejected: 2 }

  belongs_to :requestor, class_name: :User
  belongs_to :receiver, class_name: :User

  # private
  #
  #   def check_friendship
  #     puts "Checking Friendship..."
  #     puts self.inspect
  #   end
end
