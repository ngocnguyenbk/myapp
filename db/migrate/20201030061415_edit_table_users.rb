class EditTableUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :identity_card, :string
  end
end
