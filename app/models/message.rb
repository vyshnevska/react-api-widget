class Message < ActiveRecord::Base

  before_create :set_status

  def set_status
    self.status = 'unread'
  end
end
