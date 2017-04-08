class Channel < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :user

  has_many :messages
  has_many :subscriptions, dependent: :destroy

  scope :active, -> { where(active: true) }
  scope :by_popularity, -> { order('subscriptions_count desc') }
end
