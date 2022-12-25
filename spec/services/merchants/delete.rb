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

  context 'raise error for merchant to delete if transactions exist' do
    let!(:transaction) { create(:transaction, merchant: merchant) }

    it 'should raise error' do
      expect{
        subject.execute(merchant: merchant)
      }.to raise_error("Can't be destroy due to active payment transactions exist")
    end
  end
end