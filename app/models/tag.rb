class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :taggables, through: :taggings

  validates :name, presence: true
end
