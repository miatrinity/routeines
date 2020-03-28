class UpdateRoutineIdColumnForSteps < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :flow_steps, :steps, column: :step_id
    add_foreign_key :flow_steps, :steps, on_delete: :cascade
  end
end
