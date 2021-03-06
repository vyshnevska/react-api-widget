class UserSerializer < ActiveModel::Serializer

  attributes :myMessagesCount, :subscriptionsCount, :username, :email,
             :friends, :full_name, :currentUser

  has_one   :channel
  has_many  :myMessages
  has_many  :messagesToMe

  has_many :posts, only: [:id, :body, :slug]
  has_many :subscriptions

  def myMessages
    User.sorted_messages_by(object)
  end

  def messagesToMe
    User.sorted_messages_for(object)
  end

  def currentUser
    { id: object.id.to_s, name: object.name }
  end

  def subscriptionsCount
    object.subscriptions.count.to_s
  end

  def myMessagesCount
    myMessages.count.to_s
  end

  def friends
    object.friend_ids.map do |id|
      Rails.application.routes.url_helpers.user_path(id)
    end
  end
end