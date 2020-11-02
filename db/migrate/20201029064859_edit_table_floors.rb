class EditTableFloors < ActiveRecord::Migration[6.0]
  def change
    rename_column :floors, :floor_id, :floor_number
  end
end
