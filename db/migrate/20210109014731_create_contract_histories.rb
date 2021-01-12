class CreateContractHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :contract_histories do |t|
      t.datetime :date_changed
      t.json     :description
      t.integer  :code

      t.references :admin, index: true
      t.references :contract, index: true

      t.timestamps
    end
  end
end
