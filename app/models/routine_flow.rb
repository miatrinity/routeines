# frozen_string_literal: true

# :nodoc:
class RoutineFlow < ApplicationRecord
  enum status: { active: 0 }

  belongs_to :routine
  has_many :flow_steps, dependent: :destroy

  #def start
    # copy steps from routine
    # first step = active
  #end

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
end
