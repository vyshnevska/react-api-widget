class ChannelSerializer < ActiveModel::Serializer

  attributes %i(id name image_url active)

  def image_url
    object.image.url(:thumb)
  end
end