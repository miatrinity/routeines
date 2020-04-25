# frozen_string_literal: true

RSpec.describe ApplicationHelper do
  describe 'present' do
    it 'raises exception without a block' do
      expect { helper.present(RoutineFlow.new) }.to raise_error("calling present() without a block doesn't make sense!")
    end
  end
end
