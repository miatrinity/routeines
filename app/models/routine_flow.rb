# frozen_string_literal: true

# :nodoc:
class RoutineFlow < ApplicationRecord
  enum status: { active: 0 }

  belongs_to :routine
  has_many :flow_steps, dependent: :destroy

  def start(routine)
    clone_steps_of routine
    activate_first_flow_step
  end

  #def next
    # check if last step
      # complete routine flow
    # else
    #   current step = complete
    #   next step = active
  #end

  #def complete
    # current step = complete
    # routine flow = complete
  #end

  private

  def clone_steps_of(routine)
    routine.to_chain_of_steps.each do |step|
      flow_steps << FlowStep.create(step_id: step.id)
    end
  end

  def activate_first_flow_step
    flow_steps.first.active!
  end
end
