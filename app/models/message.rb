class Message < ActiveRecord::Base
  belongs_to :channel

  ALLOWED_STATUSES = %w(read unread hidden)

  validates :status, presence: true , inclusion: ALLOWED_STATUSES

  scope 'not_hidden', -> { where.not(status: 'hidden') }

  after_initialize do
    self.status ||= 'unread'
  end
end
