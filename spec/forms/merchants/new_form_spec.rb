require 'rails_helper'

describe Merchants::NewForm do
  

  context "when new" do
    subject { Merchants::NewForm.new }
    
    it 'gets values from the merchant' do
      expect(subject.name).to eq(nil)
      expect(subject.status).to eq(nil)
      expect(subject.email).to eq(nil)
      expect(subject.description).to eq(nil)
    end
  end

  context "when creating" do
    subject { Merchants::NewForm.new(create_use_case: create_use_case) }

    let(:create_use_case) { instance_double('Merchants::CreateUc') }

    before do
      allow(create_use_case).to receive(:execute) { Merchant.new }
    end
    
    context 'missing name' do

      let(:params){{
        status: 'active',
        email: 'jessy@gmail.com',
        description: Faker::Lorem.words(number: rand(2..10)).join(' ')
      }}

      it 'should not validate' do
        expect(subject).to_not be_valid
      end

      it 'should add error' do
        subject.submit
        expect(subject.errors[:name]).to_not be_empty
      end      
    end

  end
end