require 'rails_helper'

RSpec.describe Conversation::Participant, type: :model do
  it { is_expected.to belong_to(:conversation) }
  it { is_expected.to belong_to(:user) }
end
