class Message < ActiveRecord::Base
  belongs_to :channel

  before_create :set_status

  def set_status
    self.status = 'unread'
  end
end
