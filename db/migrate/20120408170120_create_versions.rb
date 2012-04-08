class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.integer :number
      t.string :author
      t.date :authored_date
      t.string :checker
      t.date :checked_date
      t.string :approver
      t.date :approved_date
      t.string :withdrawer
      t.date :withdrawn_date
      t.integer :document_id

      t.timestamps
    end
  end
end
