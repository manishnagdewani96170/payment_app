require 'rails_helper'

RSpec.describe Merchant, type: :model do

  subject {
    described_class.new(name: "John",
                        description: "Lorem ipsum",
                        email: 'john@gmail.com',
                        status: 'active',
                        total_transaction_sum: 1.0)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is valid without a description" do
    subject.description = nil
    expect(subject).to be_valid
  end

  it "is not valid without a valid status" do
    subject.status = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with total total_transaction_sum less than 0" do
    subject.total_transaction_sum = -1.0
    expect(subject).to_not be_valid
  end

  it { should have_many(:transactions) }
  
  describe 'scopes' do
    context 'active' do
      let!(:merchant_1) { create(:merchant) }
      let!(:merchant_2) { create(:merchant, email: 'jdoe@gmail.com', status: 'inactive') }
      
      it "should return active merchants count" do
        expect(Merchant.active.count).to eq(1)
      end  
    end
  end

  describe "#destroy" do
    let(:merchant) { create(:merchant) }
    
    it "runs .check_payment_transactions_exist before destroy" do
      expect(merchant).to receive(:check_payment_transactions_exist?)
      merchant.run_callbacks(:destroy)
    end
  end

  describe 'instance_methods' do
    context '.active?' do
      let!(:merchant_1) { create(:merchant, status: 'active') }
      let!(:merchant_2) { create(:merchant, status: 'inactive') }
      
      it "should return active status true" do
        expect(merchant_1.active?).to eq(true)
      end

      it "should return active status false" do
        expect(merchant_2.active?).to eq(false)
      end 
    end
  end
end

