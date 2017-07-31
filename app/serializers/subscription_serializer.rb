class SubscriptionSerializer < ActiveModel::Serializer

  attributes %i(id channel_id user_id messages_count)

end