# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Routine, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }

    describe '#avatar' do
      it { is_expected.to validate_attachment_of(:avatar) }
    end
  end
end
