class RemoveDeviseFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_index :users, name: "index_users_on_reset_password_token"

    remove_column :users, :encrypted_password
    remove_column :users, :reset_password_token, :string
    remove_column :users, :reset_password_sent_at, :datetime
    remove_column :users, :remember_created_at, :datetime
  end
end
