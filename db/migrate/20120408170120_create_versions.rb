class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.integer :number
      t.string :state
      t.integer :document_id

      t.timestamps
    end
  end
end
