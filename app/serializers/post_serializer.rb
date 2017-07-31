class PostSerializer < ActiveModel::Serializer

  attributes  %i(id slug body published title publishedAt topImageUrl
                author channel)

  def publishedAt
    object.created_at.to_f * 1000
  end

  def topImageUrl
    object.top_image.url(:small)
  end

  def author
    { id:         object.author_id,
      name:       object.author.name || 'unknown',
      avatar_url: object.author.avatar.url(:thumb)
    }
  end

  def channel
    if  object.author && object.author.channel
      { id:     object.author.channel.id,
        name:   object.author.channel.name,
        active: object.author.channel.active
      }
    end
  end
end