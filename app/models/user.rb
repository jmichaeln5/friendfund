class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :trackable, :validatable

  has_person_name

  scope :without_user, lambda{|user| user ? {:conditions => ["users.id != ?", user.id]} : {} }


  validates :first_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 30 }

  has_many :notifications, foreign_key: :recipient_id, dependent: :destroy

  has_many :friend_requests_as_requestor, foreign_key: :requestor_id, class_name: :FriendRequest, dependent: :destroy
  has_many :friend_requests_as_receiver, foreign_key: :receiver_id, class_name: :FriendRequest, dependent: :destroy

  has_many :friendships_as_friend_a, foreign_key: :friend_a_id, class_name: :Friendship
  has_many :friendships_as_friend_b, foreign_key: :friend_b_id, class_name: :Friendship
  # has_many :friend_as, through: :friendships_as_friend_b
  # has_many :friend_bs, through: :friendships_as_friend_a

  # has_many :friendships, ->(user) { where("friend_a_id = ? OR friend_b_id = ?", self.id, self.id) }
  # has_many :friendships, ->(self) { where("friend_a_id = ? OR friend_b_id = ?", self.id, self.id) }
  # has_many :friendships, ->(user) { where("friend_a_id = ? OR friend_b_id = ?", user.id, user.id) }

  # has_many :friends, through: :friendships

  # def friendships
  #    self.friendships_as_friend_a + self.friendships_as_friend_b
  # end

  def notifications
    Notification.all.where(recipient_id: self.id)
  end

  def friend_requests
    FriendRequest.where(requestor_id: self.id).or(FriendRequest.where(receiver_id: self.id))
  end

  def has_friend_request_with?(user)
    if (FriendRequest.where(requestor_id: self.id, receiver_id: user.id).first.present? || FriendRequest.where(receiver_id: self.id, requestor_id: user.id).first.present? )
      return true
    else
      return nil
    end
  end

  def friend_request_with(user)
    if (FriendRequest.where(requestor_id: self.id, receiver_id: user.id).first.present? || FriendRequest.where(receiver_id: self.id, requestor_id: user.id).first.present? )

      friend_request = (FriendRequest.where(requestor_id: self.id, receiver_id: user.id).first || FriendRequest.where(receiver_id: self.id, requestor_id: user.id).first )

    else
      return nil
    end
  end


  def friendships
    Friendship.where(friend_a_id: self.id).or(Friendship.where(friend_b_id: self.id))
  end

  def friends_with?(user)
    return true if (Friendship.where(friend_a_id: self.id, friend_b_id: user.id).first.present? ||  Friendship.where(friend_a_id: user.id, friend_b_id: self.id).first.present?)
  end









end
