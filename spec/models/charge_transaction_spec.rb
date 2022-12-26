require 'rails_helper'

RSpec.describe ChargeTransaction, type: :model do

  let(:merchant) { create(:merchant) }
  let(:following_transaction) { create(:transaction, type: 'AuthorizeTransaction') }
  
  subject {
    described_class.new(uuid: 'abc123456efg',
                        customer_phone: 'aabc100001',
                        customer_email: 'john@gmail.com',
                        status: 'approved',
                        merchant: merchant,
                        following_transaction_id: following_transaction.id,
                        amount: 1.0)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a customer_email" do
    subject.customer_email = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an uuid" do
    subject.uuid = nil
    expect(subject).to_not be_valid
  end

  it "is valid without customer_phone" do
    subject.customer_phone = nil
    expect(subject).to be_valid
  end

  it "is not valid without a valid status" do
    subject.status = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with amount less than 0" do
    subject.amount = -1.0
    expect(subject).to_not be_valid
  end

  it "is not valid without merchant" do
    subject.merchant = nil
    expect(subject).to_not be_valid
  end

  it "is valid with no amount" do
    subject.amount = nil
    expect(subject).to_not be_valid
  end
 
  it { should have_one(:follower_transaction).class_name('Transaction').with_foreign_key('following_transaction_id') }
  it { should belong_to(:following_transaction).class_name('AuthorizeTransaction') }
  
end
