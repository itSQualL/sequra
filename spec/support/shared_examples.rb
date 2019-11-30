# frozen_string_literal: true

RSpec.shared_examples 'email format' do
  it 'is valid with good format' do
    expect(subject).to be_valid
  end

  it 'is not valid with bad format' do
    subject.email = 'bad email'
    expect(subject).not_to be_valid
  end
end
