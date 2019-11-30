# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :merchant
  belongs_to :shopper

  validates :amount, presence: true, numericality: true
  validates :merchant_id, presence: true
  validates :shopper_id, presence: true
end
