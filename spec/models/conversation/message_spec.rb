require 'rails_helper'

RSpec.describe Conversation::Message, type: :model do
  it { is_expected.to belong_to(:conversation) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_db_column(:text) }
end
