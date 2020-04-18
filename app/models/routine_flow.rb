# frozen_string_literal: true

# :nodoc:
class RoutineFlow < ApplicationRecord
  attribute :time_to_complete, :duration

  enum status: { active: 0, complete: 1 }

  belongs_to :routine
  has_many :flow_steps, dependent: :destroy

  delegate :title, to: :routine, prefix: false
end
