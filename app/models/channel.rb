class Channel < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :user
  has_many :messages
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user

  mount_uploader :image, ImageUploader

  scope :active,        -> { where active: true }
  scope :support,       -> { active.where(type: 'support') }
  scope :by_popularity, -> { order('subscriptions_count desc') }

  validates :name, presence: true, uniqueness: true

  after_initialize do
    self.image = self.user&.avatar
  end

  def to_h
    ChannelSerializer.new(self).attributes
  end
end
