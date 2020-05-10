class CreateAccount < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.integer :number
      t.string :name
      t.integer :balance
      t.string :token

      t.timestamps
    end
  end
end
