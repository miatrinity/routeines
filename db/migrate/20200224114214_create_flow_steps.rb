class CreateFlowSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :flow_steps do |t|
      t.belongs_to :routine_flow, null: false, foreign_key: true
      t.references :step, null: false, foreign_key: true
      t.string :time_to_complete, default: 0
      t.integer :status, default: 0
    end
  end
end
