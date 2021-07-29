class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :trackable, :validatable

  has_person_name

  validates :first_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 30 }

  ## # https://medium.com/@elizabethprendergast/using-custom-relation-queries-to-establish-friends-and-friendships-in-rails-and-activerecord-6c6e5825433a

  has_many :friend_requests_as_requestor, foreign_key: :requestor_id, class_name: :FriendRequest
  has_many :friend_requests_as_receiver, foreign_key: :receiver_id, class_name: :FriendRequest

  has_many :friendships_as_friend_a, foreign_key: :friend_a_id, class_name: :Friendship
  has_many :friendships_as_friend_b, foreign_key: :friend_b_id, class_name: :Friendship
  has_many :friend_as, through: :friendships_as_friend_b
  has_many :friend_bs, through: :friendships_as_friend_a


  # has_many :friendships, ->(user) { where("friend_a_id = ? OR friend_b_id = ?", user.id, user.id) }
  has_many :friends, through: :friendships


  # def friendships
  #    self.friendships_as_friend_a + self.friendships_as_friend_b
  # end

end
