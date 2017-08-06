class Post < ActiveRecord::Base

  include  Concerns::Taggable
  # acts_as_taggable

  mount_uploader :top_image, ImageUploader
  mount_uploader :image_1, ImageUploader
  mount_uploader :image_2, ImageUploader

  validates :title,  presence: true
  validates :slug,   presence: true, uniqueness: true
  validates :author, presence: true

  scope :published, -> { where(published: true) }
  scope :original,  -> { where(parent_post_id: nil) }
  scope :recent,    -> { order('updated_at desc') }

  has_one :channel, through: :author

  has_many :subscriptions, through: :channel
  has_many :comments, class_name: 'Post', foreign_key: :parent_post_id
  has_many :replies, class_name: 'Post', through: :comments, source: :comments

  belongs_to :parent_post, class_name: 'Post'
  belongs_to :author, class_name: 'User', foreign_key: :author_id


  def to_param
    slug
  end

  def subscription_hash(current_user = nil)
    if current_user
      {
        isSubscribed: self.subscriptions.map(&:user_id).include?(current_user.id),
        currentUser:  { id: current_user.id }
      }
    else
      { isSubscribed: false,  currentUser: nil }
    end
  end

  def to_h
    PostSerializer.new(self).attributes
  end

  def self.find(input)
    if input.is_a?(Integer)
      super
    else
      find_by_slug(input)
    end
  end

  def to_j
    obj = ActiveModelSerializers::SerializableResource.new(self, {})
    obj.to_json
  end
end