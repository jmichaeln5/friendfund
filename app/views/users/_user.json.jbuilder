json.extract! user, :id, :first_name, :last_name, :phone_number, :email, :username, :created_at, :updated_at
json.url user_url(user, format: :json)

json.user user
