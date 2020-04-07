# frozen_string_literal: true

RSpec.describe Routine do
  describe '#title' do
    it { should validate_presence_of(:title) }
  end

  describe '#avatar' do
    it { is_expected.to validate_attachment_of(:avatar) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:steps) }
    it { should have_many(:routine_flows) }
  end
end
