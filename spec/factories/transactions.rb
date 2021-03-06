# frozen_string_literal: true

require 'securerandom'

FactoryBot.define do
  factory :transaction do
    source_account_id { SecureRandom.random_number(9999) }
    destination_account_id { SecureRandom.random_number(9999) }
    amount { 50_000 }
    not_approved { true }
  end
end
