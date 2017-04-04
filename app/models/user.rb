class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_many :posts
  has_one  :channel
  has_many :own_messages, through: :channel, source: :messages
  has_many :subscriptions, dependent: :destroy
  has_many :messages_feed, through: :subscriptions, source: :user, class_name: 'Message'

  before_create :set_auth_token!

  def generate_auth_token_and_save!
    token =  generate_auth_token
    self.update_columns(auth_token: token, token_created_at: Time.zone.now)
    token
  end

  def generate_auth_token
    SecureRandom.hex
  end

  def invalidate_auth_token
    self.update_columns(auth_token: nil, token_created_at: nil)
  end

  def name
    self.username || "user-000#{self.id}"
  end

  private
    def set_auth_token!
      self.auth_token ||= generate_auth_token
      self.token_created_at ||= Time.zone.now
    end
end