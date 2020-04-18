# frozen_string_literal: true

RSpec.describe RoutineFlow do
  describe 'associations' do
    it { should belong_to(:routine) }
    it { should have_many(:flow_steps).dependent(:destroy) }
  end

  describe 'newly created routine flow' do
    it 'has status of :active' do
      routine_flow = RoutineFlow.new

      expect(routine_flow).to be_active
    end
  end
end
