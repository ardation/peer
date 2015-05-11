describe User do
  subject { build(:user, email: 'user@example.com', mobile: 'a1^2#3kjb$907') }
  it { is_expected.to respond_to(:email) }
  it('#email returns a string') { expect(subject.email).to match 'user@example.com' }
  it { is_expected.to respond_to(:mobile) }
  it { is_expected.to validate_presence_of(:mobile) }
  it { is_expected.to validate_uniqueness_of(:mobile) }
  it('#mobile returns a numeric string') { expect(subject.mobile).to match '123907' }
  it { is_expected.to have_many(:messages).dependent(:destroy).class_name(Conversation::Message) }
  it { is_expected.to have_many(:participants).dependent(:destroy).class_name(Conversation::Participant) }
  it { is_expected.to have_many(:conversations).through(:participants).dependent(:destroy) }
  it { is_expected.to have_many(:friends).through(:friendships) }
  it { is_expected.to have_many(:friendships).dependent(:destroy).class_name(User::Friendship) }
  it { is_expected.to have_many(:inverse_friends).through(:inverse_friendships).source(:user) }
  it do
    is_expected.to have_many(:inverse_friendships)
      .dependent(:destroy).class_name(User::Friendship).with_foreign_key(:friend_id)
  end
end
