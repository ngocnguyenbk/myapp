class CreateServiceItems < ActiveRecord::Migration[6.0]
  def change
    create_table :service_items do |t|
      t.integer  :quantity, null: false
      t.string   :unit, null: false
      t.decimal  :total, null: false
      t.decimal  :unit_price, null: false

      t.string   :type, null: false

      t.references :invoice, index: true

      t.timestamps
    end
  end
end
