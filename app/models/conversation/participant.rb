class Conversation
  class Participant < ActiveRecord::Base
    belongs_to :conversation, inverse_of: :participants
    belongs_to :user, inverse_of: :participants
  end
end
