# frozen_string_literal: true

ActiveRecord::Schema.define(version: 20_200_513_004_233) do
  create_table 'accounts', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
    t.integer 'number'
    t.string 'name'
    t.integer 'balance'
    t.string 'token'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'transactions', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
    t.integer 'source_account_id'
    t.integer 'destination_account_id'
    t.integer 'amount'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.boolean 'not_approved', default: true
  end
end
