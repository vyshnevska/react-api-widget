class MessageSerializer < ActiveModel::Serializer

  attributes :id, :content, :status, :created_at

  def id
    object.id.to_s
  end

  def content
    object.content.to_s
  end

  def status
    object.status.to_s
  end

  def created_at
    object.created_at.to_f * 1000
  end

end
