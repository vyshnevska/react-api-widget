class Message < ActiveRecord::Base
  belongs_to :channel

  before_create :set_status

  def set_status
    self.status = 'unread'
  end


  def for_react
    result = %i(id content status).inject({}){ |hash, attr|
      hash[:"#{attr}"] = self.send(attr); hash
    }
    result[:createdAt] = self.created_at.to_f * 1000
    result
  end
end
