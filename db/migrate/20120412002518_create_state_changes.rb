class CreateStateChanges < ActiveRecord::Migration
  def change
    create_table :state_changes do |t|
      t.string :user
      t.string :state
      t.string :event
      t.integer :version_id

      t.timestamps
    end
  end
end
