class AddTransaction < ActiveRecord::Migration[5.1]
  def change
    create_table :transaction do |t|
      t.integer :source_account_id
      t.integer :destination_account_id
      t.integer :amount

      t.timestamps
    end
  end
end
