FactoryGirl.define do
  factory :user_friendship, class: 'User::Friendship' do
    user
    association :friend, factory: :user
  end

end
