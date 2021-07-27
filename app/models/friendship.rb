class Friendship < ApplicationRecord
  # belongs_to :user
  # belongs_to :friend, class_name: "User"

  ## # https://medium.com/@elizabethprendergast/using-custom-relation-queries-to-establish-friends-and-friendships-in-rails-and-activerecord-6c6e5825433a
  ## #
  belongs_to :friend_a, class_name: :User
  belongs_to :friend_b, class_name: :User

end
