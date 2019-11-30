# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'associations' do
    it { should have_many(:disbursements) }
    it { should have_many(:orders) }
  end

  describe 'validations' do
    subject { described_class.new(cif: 'B611111111', email: 'good@email.com', name: 'test') }

    include_examples 'email format'

    it { should validate_presence_of(:cif) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }

    it { should validate_uniqueness_of(:cif) }
    it { should validate_uniqueness_of(:email) }
  end
end
