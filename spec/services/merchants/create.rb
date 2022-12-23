require 'rails_helper'

describe Merchants::Create, type: :service do
  
  subject { described_class.new }

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

  it 'should add the merchant' do
    expect{
      subject.execute(params: params)
    }.to change {Merchant.count}.by(+1)
  end
end