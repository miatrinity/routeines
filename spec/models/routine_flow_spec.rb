# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoutineFlow, type: :model do
  describe 'newly created routine flow' do
    it 'has status of :active' do
      routine_flow = RoutineFlow.new

      expect(routine_flow).to be_active
    end

    it 'has duration of 0' do
      routine_flow = RoutineFlow.new

      expect(routine_flow.time_to_complete).to eql('0')
    end
  end

  describe '#start' do
    it "clones associated routine's steps as flow_steps" do
      routine = create(:routine, :with_steps)

      routine.routine_flows << RoutineFlow.create
      routine_flow = routine.routine_flows.last

      routine_flow.start(routine)

      expect(routine_flow.flow_steps.count).to eql(routine.steps.count)
      expect(flow_step_titles_for(routine_flow)).to eql(step_titles_for(routine))
    end

    it "activates first flow step" do
      routine = create(:routine, :with_steps)

      routine.routine_flows << RoutineFlow.create
      routine_flow = routine.routine_flows.last

      routine_flow.start(routine)

      expect(routine_flow.flow_steps.first.status).to eql('active')
    end
  end

  describe 'associations' do
    it { should belong_to(:routine) }
    it { should have_many(:flow_steps).dependent(:destroy) }
  end

  private

  def flow_step_titles_for(routine_flow)
    routine_flow.flow_steps.map{|flow_step| flow_step.step.title}
  end

  def step_titles_for(routine)
    routine.to_chain_of_steps.map(&:title)
  end
end
