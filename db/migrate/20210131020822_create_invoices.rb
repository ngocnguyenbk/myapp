class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.datetime :date_export, null: false, index: true
      t.decimal  :reduce
      t.decimal  :total, null: false

      t.references :contract, index: true

      t.timestamps
    end
  end
end
