class Channel < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :user
  has_many :messages
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user

  mount_uploader :image, ImageUploader

  scope :active,        -> { where(active: true) }
  scope :by_popularity, -> { order('subscriptions_count desc') }

  validates :name, presence: true, uniqueness: true

  after_initialize do
    self.image = self.user&.avatar
  end

  def for_react
    ({}).tap do |data|
      data[:id]        = self.id
      data[:name]      = self.name
      data[:image_url] = self.image.url(:thumb)
    end
  end
end
