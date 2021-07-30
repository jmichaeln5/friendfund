module FriendRequestsHelper

  def get_friendship_status(friend_request)
    case friend_request.status
    when "pending"
      puts " "
      puts "*"*50
      puts "#{friend_request.requestor.name} wants to be friends. Request Pending"
      puts "*"*50
      puts " "

    when "accepted"
      puts " "
      puts "*"*50
      puts "#{friend_request.requestor.name} wants to be friends. Request Accepted"
      puts "*"*50
      puts " "

    when "rejected"
      puts " "
      puts "*"*50
      puts "#{friend_request.requestor.name} wants to be friends. Request Rejected"
      puts "*"*50
      puts " "

    else
      puts "*"*50
      puts "Hitting something else...."
      puts "*"*50
      puts " "

    end
  end

end
