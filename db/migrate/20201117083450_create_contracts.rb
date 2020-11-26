class CreateContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts do |t|
      t.integer :holder_id
      t.integer :room_id
      t.decimal :room_price, precision: 10
      t.decimal :deposited_money, precision: 10
      t.date :started_date
      t.date :ended_date

      t.datetime :deleted_at
      t.boolean :active, default: true, null: false

      t.timestamps
    end
  end
end
