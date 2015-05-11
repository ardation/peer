FactoryGirl.define do
  factory :conversation_participant, class: 'Conversation::Participant' do
    conversation
    user
  end
end
