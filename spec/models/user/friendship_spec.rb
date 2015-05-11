require 'rails_helper'

RSpec.describe User::Friendship, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:friend).class_name('User') }
  it 'create reciprocal friendship' do
    expect { create(:user_friendship) }.to change { User::Friendship.count }.from(0).to(2)
  end
end
