class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_many :posts, foreign_key: :author_id
  has_one  :channel
  has_many :own_messages, through: :channel, source: :messages
  has_many :subscriptions, dependent: :destroy
  has_many :messages_feed, through: :subscriptions, source: :user, class_name: 'Message'

  scope :sorted_messages_for, -> (user) { user.messages_feed.not_hidden.order(status: :desc, created_at: :desc) }
  scope :sorted_messages_by,  -> (user) { user.own_messages.not_hidden.order(status: :desc, created_at: :desc) }

  before_create :set_auth_token!
  before_save :update_auth_token!, if: :current_sign_in_at_changed?

  def generate_and_save_auth_token!
    token =  generate_auth_token
    self.update_columns(auth_token: token, token_created_at: Time.zone.now)
    token
  end

  def invalidate_auth_token
    self.update_columns(auth_token: nil, token_created_at: nil)
  end

  def name
    self.username.presence || "user-000#{self.id}"
  end

  def owner_of? post
    post.author_id == self.id
  end

  # TODO: remove
  def for_react
    { id: self.id, name: self.name, subscriptions: self.subscriptions.count }
  end

  private
    def generate_auth_token
      SecureRandom.hex
    end

    def update_auth_token!
      self.token_created_at = Time.zone.now
    end

    def set_auth_token!
      self.auth_token ||= generate_auth_token
      self.token_created_at ||= Time.zone.now
    end
end