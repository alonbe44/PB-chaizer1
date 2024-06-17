class AddDeviseToUsers < ActiveRecord::Migration[6.0]
  def up
    change_table :users do |t|
      # Only add email if it doesn't exist
      t.string :email, null: false, default: "" unless column_exists?(:users, :email)
      t.string :encrypted_password, null: false, default: ""
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps null: false
    end

    add_index :users, :email, unique: true unless index_exists?(:users, :email)
    add_index :users, :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token)
  end

  def down
    change_table :users do |t|
      t.remove :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
    end
  end
end