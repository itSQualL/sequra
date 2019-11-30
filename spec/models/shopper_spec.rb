# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shopper, type: :model do
  describe 'validations' do
    subject { described_class.new(email: 'customer@email.com', name: 'test', nif: '411111111Z') }

    include_examples 'email format'

    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:nif) }

    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:nif) }
  end
end
