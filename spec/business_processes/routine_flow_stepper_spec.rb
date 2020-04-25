# frozen_string_literal: true

RSpec.describe RoutineFlowStepper do
  describe '#start' do
    it "clones associated routine's steps as flow_steps" do
      routine, routine_flow = start_routine_flow

      expect(flow_step_titles_for(routine_flow)).to eql(step_titles_for(routine))
    end

    it 'has started_at set to current time' do
      freeze_time

      _, routine_flow = start_routine_flow

      expect(routine_flow.started_at).to eq(Time.current)
    end

    it 'activates first flow step' do
      _, routine_flow = start_routine_flow

      expect(routine_flow.flow_steps.first.status).to eql('active')
    end
  end

  private

  def flow_step_titles_for(routine_flow)
    routine_flow.flow_steps.map(&:title)
  end

  def step_titles_for(routine)
    routine.to_chain_of_steps.map(&:title)
  end

  def start_routine_flow
    routine = create(:routine, :with_steps)

    routine_flow = RoutineFlow.create(routine: routine)

    RoutineFlowStepper.new(routine_flow).start

    [routine, routine_flow]
  end
end
