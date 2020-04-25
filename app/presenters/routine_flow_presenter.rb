# frozen_string_literal: true

# :nodoc:
class RoutineFlowPresenter < BasePresenter
  include Buttons

  presents :routine_flow
  delegate :routine, :title, to: :routine_flow, prefix: false

  def completed_at
    formatted_date_time = routine_flow.completed_at.to_s(:long_ordinal)
    "completed on #{formatted_date_time}"
  end

  def remaining_flow_steps
    "<strong>#{upcoming_flow_step_count}</strong> #{pluralized_flow_step} remaining!".html_safe
  end

  def active_flow_step_title
    active_flow_step.title
  end

  def upcoming_flow_steps
    routine_flow.flow_steps.upcoming
  end

  def routine_flow_progress
    (complete_flow_step_count / Float(all_flow_step_count) * 100).floor
  end

  private

  def upcoming_flow_step_count
    routine_flow.flow_steps.upcoming.size + 1
  end

  def pluralized_flow_step
    'flow step'.pluralize upcoming_flow_step_count
  end

  def http_method
    if routine_flow.flow_steps.upcoming.any?
      :put
    else
      :delete
    end
  end

  def finish_step_path
    routine_routine_flow_path(routine, routine_flow)
  end

  def active_flow_step
    routine_flow.flow_steps.active.first
  end

  def complete_flow_step_count
    routine_flow.flow_steps.complete.count
  end

  def all_flow_step_count
    routine_flow.flow_steps.count
  end
end
