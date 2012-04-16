class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :email
      t.string    :name
      t.string    :password_digest
      t.boolean   :confirmed
      t.string    :auth_token
      t.string    :confirmation_token
      t.datetime  :confirmation_sent_at
      t.string    :password_reset_token
      t.datetime  :password_reset_sent_at

      t.timestamps
    end
  end
end
