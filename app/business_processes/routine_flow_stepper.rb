class RoutineFlowStepper
  def initialize(routine_flow)
    @routine_flow = routine_flow
    @routine = routine_flow.routine
    @flow_steps = routine_flow.flow_steps
  end

  def start
    clone_steps_of routine
    activate_first_flow_step
    update_start_time
  end

  def take_next_flow_step
    current_flow_step.complete!
    next_flow_step.active!
  end

  def complete_routine_flow
    current_flow_step.complete!
    routine_flow.complete!
    update_completed_at_and_duration
  end

  private

  attr_reader :routine_flow, :routine, :flow_steps

  def clone_steps_of(routine)
    FlowStep.transaction do
      routine.to_chain_of_steps.each do |step|
        flow_steps.create(step_id: step.id)
      end
    end
  end

  def activate_first_flow_step
    flow_steps.first.active!
  end

  def update_start_time
    routine_flow.update(started_at: Time.current)
  end

  def update_completed_at_and_duration
    completed_at = Time.current
    routine_flow.update(
      completed_at: completed_at,
      time_to_complete: time_to_complete_from(completed_at, routine_flow.started_at)
    )
  end

  def current_flow_step
    flow_steps.active.last
  end

  def next_flow_step
    flow_steps.upcoming.first
  end

  def time_to_complete_from(completed_at, started_at)
    ActiveSupport::Duration.build(completed_at - started_at)
  end
end
