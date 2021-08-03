json.array! Notification.all do | notification |
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

end
