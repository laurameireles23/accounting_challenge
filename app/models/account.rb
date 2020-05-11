# frozen_string_literal: true

class Article < ApplicationRecord
  validates :name, presence: true
  validates :balance, presence: true
end
