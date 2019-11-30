# frozen_string_literal: true

class Shopper < ApplicationRecord
  EMAIL_REGEX = /.+@.+\..+/.freeze

  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }
  validates :name, presence: true
  validates :nif, presence: true, uniqueness: true
end
