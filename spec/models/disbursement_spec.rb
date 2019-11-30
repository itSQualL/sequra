# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Disbursement, type: :model do
  subject do
    merchant = Merchant.create(cif: 'B611111111', email: 'good@email.com', name: 'test')
    described_class.create(amount: 50.5, week: 40, year: 2019, merchant_id: merchant.id)
  end

  describe 'associations' do
    it { should belong_to(:merchant) }

    it { should have_many(:orders) }
  end

  describe 'validations' do
    it { should validate_numericality_of(:amount) }
    it { should validate_numericality_of(:week) }
    it { should validate_numericality_of(:year) }

    it { should validate_presence_of(:amount) }

    it { should validate_uniqueness_of(:week).scoped_to(%i[merchant_id year]) }
  end

  describe '.process' do
    before do
      Merchant.destroy_all

      merchant = Merchant.create(cif: 'B511111', email: 'merchant@email.com', name: 'merchant')
      shopper = Shopper.create(nif: 'B611111111', email: 'good@email.com', name: 'test')

      Order.create(amount: 49, merchant_id: merchant.id, shopper_id: shopper.id, completed_at: Time.now)
      Order.create(amount: 150, merchant_id: merchant.id, shopper_id: shopper.id, completed_at: Time.now)
      Order.create(amount: 300, merchant_id: merchant.id, shopper_id: shopper.id, completed_at: Time.now)
      Order.create(amount: 500, merchant_id: merchant.id, shopper_id: shopper.id)
    end

    it 'returns correct disbursements' do
      described_class.process
      expect(Float(Disbursement.first.amount)).to eq(494.535)
    end
  end
end
