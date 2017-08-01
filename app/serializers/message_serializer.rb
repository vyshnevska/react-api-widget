class MessageSerializer < ActiveModel::Serializer

  attributes :id, :content, :status, :created_at

  def created_at
    object.created_at.to_f * 1000
  end

end
