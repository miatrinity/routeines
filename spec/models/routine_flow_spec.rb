# frozen_string_literal: true

RSpec.describe RoutineFlow do
  describe 'newly created routine flow' do
    it 'has status of :active' do
      routine_flow = RoutineFlow.new

      expect(routine_flow).to be_active
    end
  end

  describe '#start!' do
    it "clones associated routine's steps as flow_steps" do
      routine, routine_flow = start_routine_flow

      expect(flow_step_titles_for(routine_flow)).to eql(step_titles_for(routine))
    end

    it 'has started_at set to current time' do
      freeze_time

      routine, routine_flow = start_routine_flow

      expect(routine_flow.started_at).to eq(Time.current)
    end


    it 'activates first flow step' do
      _, routine_flow = start_routine_flow

      expect(routine_flow.flow_steps.first.status).to eql('active')
    end
  end

  describe '#take_next_flow_step!' do
    it 'should complete current step and activate next step' do
      _, routine_flow = start_routine_flow

      routine_flow.take_next_flow_step!

      expect(routine_flow.flow_steps.first).to be_complete
      expect(routine_flow.flow_steps.second).to be_active
    end
  end

  describe '#complete_routine_flow!' do
    it 'should complete routine flow if step is the last step' do
      routine, routine_flow = start_routine_flow

      (routine.steps.count-1).times { routine_flow.take_next_flow_step! }
      routine_flow.complete_routine_flow!

      expect(routine_flow).to be_complete
    end

    it 'should update finished_at with current time' do
      freeze_time
      routine, routine_flow = start_routine_flow

      (routine.steps.count-1).times { routine_flow.take_next_flow_step! }
      routine_flow.complete_routine_flow!

      expect(routine_flow.completed_at).to eq(Time.current)
    end

    it 'should update time_to_complete with the duration' do
      freeze_time

      start_time = Time.current - 7.minutes
      finish_time = start_time + 7.minutes

      travel_to start_time

      routine, routine_flow = start_routine_flow

      travel_to finish_time

      (routine.steps.count-1).times { routine_flow.take_next_flow_step! }
      routine_flow.complete_routine_flow!

      expect(routine_flow.time_to_complete).to eq(7.minutes)
    end
  end

  describe 'associations' do
    it { should belong_to(:routine) }
    it { should have_many(:flow_steps).dependent(:destroy) }
  end

  private

  def flow_step_titles_for(routine_flow)
    routine_flow.flow_steps.map { |flow_step| flow_step.title }
  end

  def step_titles_for(routine)
    routine.to_chain_of_steps.map(&:title)
  end

  def start_routine_flow
    routine = create(:routine, :with_steps)

    routine_flow = RoutineFlow.create(routine: routine)

    routine_flow.start!

    [routine, routine_flow]
  end
end
