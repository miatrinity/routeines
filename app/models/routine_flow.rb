# frozen_string_literal: true

# :nodoc:
class RoutineFlow < ApplicationRecord
  enum status: { active: 0, complete: 1 }

  belongs_to :routine
  has_many :flow_steps, dependent: :destroy

  delegate :title, to: :routine, prefix: false

  def start!
    clone_steps_of routine
    activate_first_flow_step
  end

  def take_next_flow_step!
    current_flow_step.complete!
    next_flow_step.active!
  end

  def complete_routine_flow!
    current_flow_step.complete!
    complete!
  end

  private

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

  def current_flow_step
    flow_steps.active.last
  end

  def next_flow_step
    flow_steps.upcoming.first
  end
end
