require 'rails_helper'

describe Merchants::UpdateUc, type: :service do
  
  subject { described_class.new(update_service: update_service) }

  let(:update_service) { Merchants::Update.new }

  let(:merchant) { create(:merchant) }

  let(:params){{
    name: 'Jessy',
    status: 'active',
    email: 'jessy@gmail.com',
    description: Faker::Lorem.words(number: rand(2..10)).join(' ')
  }}
  
  it 'should return the merchant' do
    expect(
      subject.execute(merchant: merchant, params: params)
    ).to be_a(Merchant)
  end
end