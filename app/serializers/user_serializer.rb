class UserSerializer < ActiveModel::Serializer

  attributes :currentUser, :myMessagesCount, :subscriptionsCount

  has_one   :channel
  has_many  :myMessages
  has_many  :messagesToMe

  has_many :posts, only: [:id, :body, :slug]

  has_many :subscriptions

  def id
    object.id.to_s
  end

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

end
