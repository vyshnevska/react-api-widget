class Post < ActiveRecord::Base
  validates :slug, presence: true, uniqueness: true
  has_many :comments, class_name: 'Post', foreign_key: :parent_post_id
  belongs_to :parent_post, class_name: 'Post'
  has_many :replies, class_name: 'Post', through: :comments, source: :comments

  REACT_ATTRIBUTES = %i(slug body published title author)

  belongs_to :author, class_name: 'User', foreign_key: :author_id

  def to_param
    slug
  end

  def for_react
    REACT_ATTRIBUTES.inject({}) do |hash, attr|
      if attr == :author
        hash[:"#{attr}"] = self.send(attr).try(:name) # author name
      else
        hash[:"#{attr}"] = self.send attr
      end
      hash
    end
  end

  def self.find(input)
    if input.is_a?(Integer)
      super
    else
      find_by_slug(input)
    end
  end
end
