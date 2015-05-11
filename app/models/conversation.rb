class Conversation < ActiveRecord::Base
  paginates_per 50
  has_many :users, through: :participants
  has_many :participants, dependent: :destroy
  has_many :messages, dependent: :destroy
  enum mode: [:single, :multiple]

  def code
    Base62.encode id
  end
end
