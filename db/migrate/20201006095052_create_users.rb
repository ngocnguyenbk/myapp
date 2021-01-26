class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.datetime :birthday
      t.datetime :deleted_at
      t.boolean :active, default: true, null: false

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :phone, unique: true
  end
end
