# frozen_string_literal: true

class Account < ApplicationRecord
  validates :number, :name, :balance, :token, presence: true

  validates_uniqueness_of :number
end
