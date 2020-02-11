# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Routine, type: :model do
  describe '#title' do
    it { should validate_presence_of(:title) }
  end

  describe '#avatar' do
    it { is_expected.to validate_attachment_of(:avatar) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
