class RoutineFlowPresenter
  include ViewCompatibilityPack

  delegate :routine, to: :routine_flow, prefix: false

  def initialize(routine_flow)
    @routine_flow = routine_flow
  end

  def routine_flow_title
    routine_flow.title
  end

  def remaining_flow_steps
    "<strong>#{upcoming_flow_step_count}</strong> #{pluralized_flow_step} remaining!".html_safe
  end

  def finish_step_button
    link_to "Finish Step",
      finish_step_path,
      method: http_method,
      class: "button is-large is-info is-fullwidth"
  end

  def active_flow_step_title
    active_flow_step.title
  end

  def upcoming_flow_steps
    routine_flow.flow_steps.upcoming
  end

  private

  attr_reader :routine_flow

  def upcoming_flow_step_count
    routine_flow.flow_steps.upcoming.size + 1
  end

  def pluralized_flow_step
    "flow step".pluralize upcoming_flow_step_count
  end

  def http_method
    if routine_flow.flow_steps.upcoming.any?
      :put
    else
      :delete
    end
  end

  def finish_step_path
    url_helpers.routine_routine_flow_path(routine, routine_flow)
  end

  def active_flow_step
    routine_flow.flow_steps.active.first
  end
end
