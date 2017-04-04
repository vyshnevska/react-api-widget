class Message < ActiveRecord::Base
  belongs_to :channel

  ALLOWED_STATUSES = %w(read unread hidden)

  validates :status, presence: true , inclusion: ALLOWED_STATUSES

  scope 'not_hidden', -> { where.not(status: 'hidden') }

  after_initialize do
    self.status ||= 'unread'
  end

  def for_react
    result = %i(id content status).inject({}){ |hash, attr|
      hash[:"#{attr}"] = self.send(attr); hash
    }
    result[:createdAt] = self.created_at.to_f * 1000
    result
  end
end
