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

  describe '#start!' do
    it "clones associated routine's steps as flow_steps" do
      routine, routine_flow = start_routine_flow

      expect(flow_step_titles_for(routine_flow)).to eql(step_titles_for(routine))
    end

    it 'activates first flow step' do
      _, routine_flow = start_routine_flow

      expect(routine_flow.flow_steps.first.status).to eql('active')
    end
  end

  describe '#take_next_step!' do
    it 'should complete current step and activate next step' do
      _, routine_flow = start_routine_flow

      routine_flow.take_next_step!

      expect(routine_flow.flow_steps.first).to be_complete
      expect(routine_flow.flow_steps.second).to be_active
    end
  end

  describe '#complete!' do
    it 'should complete routine flow if step is the last step' do
      routine, routine_flow = start_routine_flow

      (routine.steps.count-1).times { routine_flow.take_next_step! }
      routine_flow.complete!

      expect(routine_flow).to be_complete
    end
  end

  describe 'associations' do
    it { should belong_to(:routine) }
    it { should have_many(:flow_steps).dependent(:destroy) }
  end

  private

  def flow_step_titles_for(routine_flow)
    routine_flow.flow_steps.map { |flow_step| flow_step.step.title }
  end

  def step_titles_for(routine)
    routine.to_chain_of_steps.map(&:title)
  end

  def start_routine_flow
    routine = create(:routine, :with_steps)

    routine_flow = RoutineFlow.create
    routine.routine_flows << routine_flow

    routine_flow.start!

    [routine, routine_flow]
  end
end
