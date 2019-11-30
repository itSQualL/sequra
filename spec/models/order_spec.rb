# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { should belong_to(:disbursement) }
    it { should belong_to(:merchant) }
    it { should belong_to(:shopper) }
  end

  describe 'validations' do
    it { should validate_numericality_of(:amount) }

    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:merchant_id) }
  end
end
