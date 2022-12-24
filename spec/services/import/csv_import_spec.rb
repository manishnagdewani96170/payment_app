require 'rails_helper'

describe Import::CsvImport, type: :service do
  
  describe 'when merchant file imported' do
    
    context 'when passed arguments are valid' do
      let(:csv_path) { 'spec/support/files/merchants.csv' }
      let(:model) { 'Merchant' }
      
      subject { described_class.new(csv_path, model) }

      it 'should import merchants' do
        subject.execute
        expect(Merchant.find_by(email: 'john.test@gmail.com').name).to eq 'John L'
      end
    end

    context 'when passed arguments are invalid' do
      let(:csv_path) { 'spec/support/files/merchants.csv' }
      let(:model) { 'Test' }
      
      subject { described_class.new(csv_path, model) }

      it 'should return error message' do
        expect{ subject.execute }.to raise_error(RuntimeError, 'Invalid arguments passed')
      end
    end
  end

  describe 'when admin file imported' do
    
    context 'when passed arguments are valid' do
      let(:csv_path) { 'spec/support/files/admins.csv' }
      let(:model) { 'Admin' }
      
      subject { described_class.new(csv_path, model) }

      it 'should import admins' do
        subject.execute
        expect(Admin.find_by(email: 'john.l_adm_test@gmail.com').name).to eq 'John L'
      end
    end

    context 'when passed arguments are invalid' do
      let(:csv_path) { 'spec/support/files/admins.csv' }
      let(:model) { 'Test' }
      
      subject { described_class.new(csv_path, model) }

      it 'should return error message' do
        expect{ subject.execute }.to raise_error(RuntimeError, 'Invalid arguments passed')
      end
    end
  end
end