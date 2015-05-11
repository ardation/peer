require 'rails_helper'

RSpec.describe Conversation, type: :model do
  before { allow(subject).to receive_messages(id: 1) }
  it { is_expected.to have_many(:participants).dependent(:destroy) }
  it { is_expected.to have_many(:messages).dependent(:destroy) }
  it { is_expected.to have_many(:users).through(:participants) }
  it { is_expected.to define_enum_for(:mode).with([:single, :multiple]) }
  describe '.code' do
    it('encodes id') { expect(subject.code).to eq(Base62.encode subject.id) }
  end
end
