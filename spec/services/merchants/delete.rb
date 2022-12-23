require 'rails_helper'

describe Merchants::Delete, type: :service do
  
  subject { described_class.new }

  let!(:merchant) { create(:merchant) }

  it 'should return true' do
    expect(
      subject.execute(merchant: merchant)
    ).to be_truthy
  end

  it 'should delete the merchant' do
    expect{
      subject.execute(merchant: merchant)
    }.to change {Merchant.count}.by(-1)
  end
end