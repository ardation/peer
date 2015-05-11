class User < ActiveRecord::Base
  paginates_per 50
  devise :database_authenticatable, :confirmable,
         :recoverable, :trackable, :validatable,
         :registerable
  include DeviseTokenAuth::Concerns::User
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, if: :new_record?
  has_many :messages, class_name: Conversation::Message, dependent: :destroy
  has_many :participants, class_name: Conversation::Participant, dependent: :destroy
  has_many :conversations, through: :participants, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :friendships, class_name: User::Friendship, dependent: :destroy
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  has_many :inverse_friendships, class_name: User::Friendship, dependent: :destroy, foreign_key: 'friend_id'
  validates :mobile, presence: true, uniqueness: true

  before_validation do
    self.password = Devise.friendly_token unless password
    self.provider = 'mobile' unless provider
    self.uid = mobile if provider == 'mobile'
  end

  def set_default_role
    self.role ||= :user
  end

  def mobile=(mobile)
    write_attribute :mobile, mobile.try(:gsub, /\D/, '')
  end
end
