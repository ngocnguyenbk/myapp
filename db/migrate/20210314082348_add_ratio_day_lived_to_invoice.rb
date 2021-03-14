class AddRatioDayLivedToInvoice < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :day_lived, :integer, default: 1, null: false
    add_column :invoices, :day_in_month, :integer, default: 1, null: false
  end
end
