class Conversation
  class Message < ActiveRecord::Base
    belongs_to :conversation
    belongs_to :user
  end
end
