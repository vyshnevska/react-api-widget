class Post < ActiveRecord::Base
  validates :slug, presence: true, uniqueness: true
  has_many :comments, class_name: 'Post', foreign_key: :parent_post_id
  belongs_to :parent_post, class_name: 'Post'
  has_many :replies, class_name: 'Post', through: :comments, source: :comments

  def to_param
    slug
  end

   def self.find(input)
    if input.is_a?(Integer)
      super
    else
      find_by_slug(input)
    end
  end
end
