# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoutineFlow, type: :model do
  describe 'newly created routine' do
    it 'has status of :active' do
      routine_flow = RoutineFlow.new

      expect(routine_flow).to be_active
    end

    it 'has duration of 0' do
      routine_flow = RoutineFlow.new

      expect(routine_flow.time_to_complete).to eql('0')
    end
  end

  describe 'associations' do
    it { should belong_to(:routine) }
    it { should have_many(:flow_steps).dependent(:destroy) }
  end
end
