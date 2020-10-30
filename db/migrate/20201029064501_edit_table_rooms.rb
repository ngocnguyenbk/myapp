class EditTableRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :holder_id, :integer
    add_column :rooms, :area, :float
    rename_column :rooms, :room_id, :room_number
  end
end
