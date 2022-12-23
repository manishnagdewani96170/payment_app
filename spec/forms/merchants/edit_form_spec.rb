require 'rails_helper'

describe Merchants::EditForm do
  

  let!(:merchant) { create(:merchant) }

  context "when editing" do
    subject { Merchants::EditForm.new(merchant: merchant) }
    
    it 'gets values from the merchant' do
      expect(subject.name).to eq(merchant.name)
      expect(subject.status).to eq(merchant.status)
      expect(subject.email).to eq(merchant.email)
      expect(subject.description).to eq(merchant.description)
    end
  end

  context "when updating" do
    subject { Merchants::EditForm.new(merchant: merchant, params: params, update_use_case: update_use_case) }
    
    let(:params){{
      name: 'Jessy',
      status: 'active',
      email: 'jessy@gmail.com',
      description: Faker::Lorem.words(number: rand(2..10)).join(' ')
    }}

    let(:update_use_case) { instance_double('Merchants::UpdateUc') }

    before do
      allow(update_use_case).to receive(:execute) { merchant }
    end

    it 'calls the update_use_case' do
      subject.submit
      expect(update_use_case).to have_received(:execute).with(merchant: merchant, params: params)
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