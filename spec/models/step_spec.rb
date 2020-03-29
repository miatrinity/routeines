# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Step, type: :model do
  describe '#title' do
    it { should validate_presence_of(:title) }
  end

  describe 'associations' do
    it { should belong_to(:routine) }
  end
end
