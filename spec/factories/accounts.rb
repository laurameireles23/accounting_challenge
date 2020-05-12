require  'securerandom'

FactoryBot.define do
  factory :account do
    number { 1234 }
    name { 'John Due' }
    balance { 150000 }
    token { SecureRandom.hex(10) }
  end
end