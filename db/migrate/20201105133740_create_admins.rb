class CreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :admins do |t|
      t.string :full_name
      t.string :email
      t.string :phone
      t.string :encrypted_password, default: "", null: false
      t.date :birthday
      t.integer :role, default: 0, null: false
      t.datetime :deleted_at
      t.datetime :remember_created_at
      t.boolean :active, default: true, null: false

      t.timestamps null: false
    end

    add_index :admins, :email, unique: true
    add_index :admins, :phone, unique: true
  end
end
