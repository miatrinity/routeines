class CreateSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :steps do |t|
      t.string :title
      t.boolean :first, default: false
      t.references :next
      t.references :routine, null: false, foreign_key: true
      t.timestamps
    end
  end
end
