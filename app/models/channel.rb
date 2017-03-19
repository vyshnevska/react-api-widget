class Channel < ActiveRecord::Base
  self.inheritance_column = nil
  belongs_to :user

  has_many :messages
end
