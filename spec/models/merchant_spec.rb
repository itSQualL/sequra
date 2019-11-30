# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    subject { described_class.new(cif: 'B611111111', email: 'good@email.com', name: 'test') }

    it { should validate_presence_of(:cif) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }

    it { should validate_uniqueness_of(:cif) }
    it { should validate_uniqueness_of(:email) }

    describe 'email format' do
      it 'is valid with good format' do
        expect(subject).to be_valid
      end

      it 'is not valid with bad format' do
        subject.email = 'bad email'
        expect(subject).not_to be_valid
      end
    end
  end
end
