class UserSerializer < ActiveModel::Serializer

  attributes :id, :msg

  has_one   :channel
  has_many  :my_messages
  has_many  :messages_to_me

  has_many :posts, only: [:id, :body, :slug]

  has_many :subscriptions

  def id
    object.id.to_s
  end

  def my_messages
    User.sorted_messages_by(object)
  end

  def messages_to_me
    User.sorted_messages_for(object)
  end

  def msg
    'helllo world'
  end
end
