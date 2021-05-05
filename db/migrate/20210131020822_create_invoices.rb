class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.datetime :date_export, null: false
      t.decimal  :reduce
      t.decimal  :total, null: false

      t.references :contract, index: true
      t.index :date_export

      t.timestamps
    end
  end
end
