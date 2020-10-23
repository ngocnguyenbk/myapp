class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.integer :room_id
      t.datetime :deleted_at
      t.boolean :active, default: true, null: false

      t.timestamps
    end
  end
end
