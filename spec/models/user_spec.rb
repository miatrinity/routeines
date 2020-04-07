# frozen_string_literal: true

RSpec.describe User do
  describe 'associations' do
    it { should have_many(:routines) }
  end
end
