require  'securerandom'

FactoryBot.define do
  factory :transactions do
    source_account_id { SecureRandom.random_number(9999) }
    destination_account_id { SecureRandom.random_number(9999) }
    amount { 50000 }
  end
end
