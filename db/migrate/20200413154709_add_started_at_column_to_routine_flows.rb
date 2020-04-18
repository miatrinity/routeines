# frozen_string_literal: true

# :nodoc:
class AddStartedAtColumnToRoutineFlows < ActiveRecord::Migration[6.0]
  def change
    add_column :routine_flows, :started_at, :datetime
  end
end
