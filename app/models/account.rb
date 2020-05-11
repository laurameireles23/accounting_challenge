# frozen_string_literal: true

class Account < ApplicationRecord
  validates :name, presence: true
  validates :balance, presence: true
end
