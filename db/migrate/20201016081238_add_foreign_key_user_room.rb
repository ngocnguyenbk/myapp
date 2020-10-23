class AddForeignKeyUserRoom < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :room, index: true
    add_reference :rooms, :floor, index: true
  end
end
