class Post < ActiveRecord::Base
  validates :slug, presence: true, uniqueness: true

  has_many :comments, class_name: 'Post', foreign_key: :parent_post_id
  has_many :replies, class_name: 'Post', through: :comments, source: :comments

  belongs_to :parent_post, class_name: 'Post'

  mount_uploader :top_image, ImageUploader
  mount_uploader :image_1, ImageUploader
  mount_uploader :image_2, ImageUploader

  scope :published, -> { where(published: true) }
  scope :original,  -> { where(parent_post_id: nil) }

  REACT_ATTRIBUTES = %i(slug body published title author)

  belongs_to :author, class_name: 'User', foreign_key: :author_id

  def to_param
    slug
  end

  def for_react
    result = %i(slug body published title author_id).inject({}){ |hash, attr|
      hash[:"#{attr}"] = self.send(attr); hash
    }

    result[:publishedAt] = self.created_at.to_f * 1000
    result[:topImageUrl] = self.top_image.url(:small)
    result[:author_name] = self.author.try(:name) || 'unknown'

    if self.author && self.author.channel
      result[:channel] = {
        name:   self.author.channel.name,
        active: self.author.channel.active
      }
    else
      result[:channel] = nil
    end
    result
  end

  def self.find(input)
    if input.is_a?(Integer)
      super
    else
      find_by_slug(input)
    end
  end
end
