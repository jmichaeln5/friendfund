json.extract! friend_request, :id, :requestor_id, :receiver_id, :status, :created_at, :updated_at
json.url friend_request_url(friend_request, format: :json)
