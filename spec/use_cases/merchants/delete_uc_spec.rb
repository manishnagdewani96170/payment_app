require 'rails_helper'

describe Merchants::DeleteUc, type: :service do
  
  subject { described_class.new(delete_service: delete_service) }

  let(:delete_service) { Merchants::Delete.new }

  let!(:merchant) { create(:merchant) }

  it 'should return true' do
    expect(
      subject.execute(merchant: merchant)
    ).to be_truthy
  end
end