# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::DisbursementsController, type: :controller do
  describe 'GET #index' do
    before do
      merchant_1 = Merchant.create(cif: 'B611111111', email: 'merchant1@email.com', name: 'm1')
      merchant_2 = Merchant.create(cif: 'B644444444', email: 'merchant2@email.com', name: 'm2')

      Disbursement.create(
        merchant_id: merchant_1.id,
        year: Time.current.year,
        week: Time.current.strftime('%U').to_i
      )

      Disbursement.create(
        merchant_id: merchant_1.id,
        year: Time.current.year - 1,
        week: Time.current.strftime('%U').to_i
      )

      Disbursement.create(
        merchant_id: merchant_2.id,
        year: Time.current.year,
        week: Time.current.strftime('%U').to_i
      )
    end

    it 'returns all disbursements without params' do
      get :index
      json = JSON.parse(response.body)
      expect(json.count).to eq(3)
    end

    it 'returns merchant disbursements with merchant_id param' do
      merchant = Merchant.first

      get :index, params: { merchant_id: merchant.id }
      json = JSON.parse(response.body)
      merchant_ids = json.map { |disbursement| disbursement['merchant_id'] }

      expect(merchant_ids.uniq.count).to eq(1)
    end

    it 'returns week disbursements with week and year params' do
      get :index, params: { year: Time.current.year - 1 }
      json = JSON.parse(response.body)
      expect(json.count).to eq(1)
    end
  end
end
