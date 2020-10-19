class AddColumnToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :status, :integer, default: 1, null: false
  end
end
