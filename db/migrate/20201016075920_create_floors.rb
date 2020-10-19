class CreateFloors < ActiveRecord::Migration[6.0]
  def change
    create_table :floors do |t|
      t.integer :floor_id
      t.datetime :deleted_at
      t.boolean :active, default: true, null: false

      t.timestamps
    end
  end
end
