class ChannelSerializer < ActiveModel::Serializer

  attributes :id, :name

  def id
    object.id.to_s
  end

  def name
    object.name
  end
end
