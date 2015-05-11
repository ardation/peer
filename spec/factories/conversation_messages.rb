FactoryGirl.define do
  factory :conversation_message, class: 'Conversation::Message' do
    text 'MyText'
    conversation_id 1
    user_id 1
  end
end
