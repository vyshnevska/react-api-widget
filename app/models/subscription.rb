class Subscription < ActiveRecord::Base

  belongs_to :channel, counter_cache: true
  belongs_to :user, counter_cache: true

  validates :channel_id, presence: true, uniqueness: { scope: :user_id }
  validates :user_id, presence: true
end
