json.array! @notifications do | notification |
  # json.actor notification.actor
  # json.recipient notification.recipient
  # json.action notification.action
  # json.notifiable notification.notifiable

  json.id notification.id
  json.actor notification.actor.name
  json.recipient notification.recipient.name
  json.action notification.action

  json.notifiable do
    json.type "a #{notification.notifiable.class.to_s.underscore.humanize}"
    # json.commentParent notification.notifiable
  end

  json.url friend_request_url(notification.notifiable.id)

  json.notification_message "New #{notification.notifiable.class.to_s.underscore.humanize.downcase} from #{notification.actor.name}."

  json.created_at_in_words "#{time_ago_in_words(notification.created_at)} ago"
  json.read_at notification.read_at

end
