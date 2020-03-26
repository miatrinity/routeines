# frozen_string_literal: true

# :nodoc:
class RoutineFlow < ApplicationRecord
  enum status: { active: 0, complete: 1 }

  belongs_to :routine
  has_many :flow_steps, dependent: :destroy

  def start!
    clone_steps_of routine
    activate_first_flow_step
  end

  def take_next_step!
    current_flow_step.complete!
    next_flow_step.active!
  end

  private

  def clone_steps_of(routine)
    routine.to_chain_of_steps.each do |step|
      flow_steps << FlowStep.create(step_id: step.id)
    end
  end

  def activate_first_flow_step
    flow_steps.first.active!
  end

  def current_flow_step
    flow_steps.active.last
  end

  def next_flow_step
    flow_steps.inactive.first
  end
end
