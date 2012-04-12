class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :title
      t.string :subtitle
      t.text :description
      t.integer :category_id

      t.timestamps
    end
  end
end
