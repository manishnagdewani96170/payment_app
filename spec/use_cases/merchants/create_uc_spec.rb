require 'rails_helper'

describe Merchants::CreateUc, type: :service do
  
  subject { described_class.new(create_service: create_service) }

  let(:create_service) { Merchants::Create.new }

  let(:params){{
    name: 'Jessy',
    status: 'active',
    email: 'jessy@gmail.com',
    description: Faker::Lorem.words(number: rand(2..10)).join(' ')
  }}

  it 'should return the merchant' do
    expect(
      subject.execute(params: params)
    ).to be_a(Merchant)
  end
end