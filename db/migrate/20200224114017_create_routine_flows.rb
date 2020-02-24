class CreateRoutineFlows < ActiveRecord::Migration[6.0]
  def change
    create_table :routine_flows do |t|
      t.integer :status, default: 0
      t.string :time_to_complete, default: 0
      t.references :flow_step, null: false, foreign_key: true
      t.belongs_to :routine, null: false, foreign_key: true
    end
  end
end
