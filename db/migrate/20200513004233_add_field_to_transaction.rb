class AddFieldToTransaction < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :not_approved, :boolean, default: true
  end
end
