# frozen_string_literal: true

# :nodoc:
class FlowStep < ApplicationRecord
  enum status: { inactive: 0, active: 1, complete: 2 }

  belongs_to :routine_flow
  belongs_to :step

  delegate :last?, to: :step
end
