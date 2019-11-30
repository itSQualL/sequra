# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { should belong_to(:disbursement).optional }
    it { should belong_to(:merchant) }
    it { should belong_to(:shopper) }
  end

  describe 'validations' do
    it { should validate_numericality_of(:amount) }
    it { should validate_presence_of(:amount) }
  end

  describe '.completed' do
    let(:merchant) { Merchant.create(cif: 'B611111111', email: 'good@email.com', name: 'test') }
    let(:shopper) { Shopper.create(nif: 'B611111111', email: 'good@email.com', name: 'test') }
    let!(:order) { Order.create(amount: 5, merchant_id: merchant.id, shopper_id: shopper.id, completed_at: Time.now) }

    before do
      Order.create(amount: 5, merchant_id: merchant.id, shopper_id: shopper.id)
    end

    it 'only returns orders with completed_at' do
      expect(described_class.completed.count).to eq(1)
      expect(described_class.completed.first.id).to eq(order.id)
    end
  end

  describe '.not_disbursed' do
    let(:merchant) { Merchant.create(cif: 'B611111111', email: 'good@email.com', name: 'test') }
    let(:shopper) { Shopper.create(nif: 'B611111111', email: 'good@email.com', name: 'test') }
    let!(:order) { Order.create(amount: 5, merchant_id: merchant.id, shopper_id: shopper.id) }

    before do
      disbursement = Disbursement.create(
        merchant_id: merchant.id,
        year: Time.current.year,
        week: Time.current.strftime('%U').to_i
      )

      Order.create(amount: 5, merchant_id: merchant.id, shopper_id: shopper.id, disbursement_id: disbursement.id)
    end

    it 'only returns orders with disbursement association' do
      expect(described_class.not_disbursed.count).to eq(1)
      expect(described_class.not_disbursed.first.id).to eq(order.id)
    end
  end

  describe '#net_amount' do
    it 'applies 1% disccount in first section' do
      order = Order.new(amount: 49)
      expect(Float(order.net_amount)).to eq(48.51)
    end

    it 'applies 0.95% disccount in second section' do
      order = Order.new(amount: 76)
      expect(Float(order.net_amount)).to eq(75.278)
    end

    it 'applies 0.85% disccount in third section' do
      order = Order.new(amount: 300)
      expect(Float(order.net_amount)).to eq(297.45)
    end
  end
end
