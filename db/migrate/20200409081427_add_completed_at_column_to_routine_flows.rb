class AddCompletedAtColumnToRoutineFlows < ActiveRecord::Migration[6.0]
  def change
    add_column :routine_flows, :completed_at, :datetime
  end
end
