class CreateResourceItems < ActiveRecord::Migration[6.0]
  def change
    create_table :resource_items do |t|
      t.float    :begin_number, null: false
      t.float    :end_number, null: false
      t.float    :quantity, null: false
      t.string   :unit, null: false
      t.decimal  :total, null: false
      t.decimal  :unit_price, null: false

      t.string   :type, null: false

      t.references :invoice, index: true

      t.timestamps
    end
  end
end
