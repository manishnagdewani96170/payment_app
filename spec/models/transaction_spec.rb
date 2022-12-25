require 'rails_helper'

RSpec.describe Transaction, type: :model do

  let(:merchant) { create(:merchant) }
  
  subject {
    described_class.new(uuid: 'abc123456efg',
                        customer_phone: 'aabc100001',
                        customer_email: 'john@gmail.com',
                        status: 'approved',
                        merchant: merchant,
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
    expect(subject).to be_valid
  end

  it { should belong_to(:merchant) }


  describe 'scopes' do
    context 'approved' do
      let!(:transaction_1) { create(:transaction) }
      let!(:transaction_2) { create(:transaction, status: 'reversed') }
      
      it "should return approved transactions count" do
        expect(Transaction.approved.count).to eq(1)
      end  
    end

    context 'reversed' do
      let!(:transaction_1) { create(:transaction, status: 'reversed') }
      let!(:transaction_2) { create(:transaction, status: 'approved') }
      
      it "should return approved transactions count" do
        expect(Transaction.reversed.count).to eq(1)
      end  
    end

    context 'refunded' do
      let!(:transaction_1) { create(:transaction, status: 'refunded') }
      let!(:transaction_2) { create(:transaction, status: 'error') }
      
      it "should return approved transactions count" do
        expect(Transaction.refunded.count).to eq(1)
      end  
    end

    context 'error' do
      let!(:transaction_1) { create(:transaction, status: 'error') }
      let!(:transaction_2) { create(:transaction, status: 'refunded') }
      
      it "should return approved transactions count" do
        expect(Transaction.error.count).to eq(1)
      end  
    end

    context 'older_than' do
      let!(:transaction_1) { create(:transaction, created_at: Time.now - 3600) }
      let!(:transaction_2) { create(:transaction, created_at: Time.now - 3800) }
      let!(:transaction_3) { create(:transaction) }
      
      it "should return older than 1 hr transactions count" do
        expect(Transaction.older_than(3600).count).to eq(2)
      end  
    end
  end


  describe 'class_methods' do
    context '.delete_past_records' do
      let!(:transaction_1) { create(:transaction, created_at: Time.now - 3600) }
      let!(:transaction_2) { create(:transaction, created_at: Time.now - 3800) }
      let!(:transaction_3) { create(:transaction) }
      
      it "should delete transactions older than given duration" do
        expect{ Transaction.delete_past_records(3600) }.to change { Transaction.count }.by(-2)
      end  
    end
  end
end
