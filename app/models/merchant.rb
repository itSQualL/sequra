# frozen_string_literal: true

class Merchant < ApplicationRecord
  EMAIL_REGEX = /.+@.+\..+/.freeze

  validates :cif, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }
  validates :name, presence: true
end
