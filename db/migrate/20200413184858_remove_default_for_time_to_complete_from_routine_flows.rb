class RemoveDefaultForTimeToCompleteFromRoutineFlows < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:routine_flows, :time_to_complete, nil)
  end
end
