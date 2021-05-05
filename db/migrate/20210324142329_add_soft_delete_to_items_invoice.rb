class AddSoftDeleteToItemsInvoice < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :deleted_at, :datetime
    add_column :invoices, :active, :boolean, default: true, null: false

    add_column :resource_items, :deleted_at, :datetime
    add_column :resource_items, :active, :boolean, default: true, null: false

    add_column :service_items, :deleted_at, :datetime
    add_column :service_items, :active, :boolean, default: true, null: false
  end
end
