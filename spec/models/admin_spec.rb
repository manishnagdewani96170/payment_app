require 'rails_helper'

RSpec.describe Admin, type: :model do

  subject {
    described_class.new(name: "John",
                        email: 'john_admin@gmail.com',
                        status: 'active')
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


  it "is not valid without a valid status" do
    subject.status = nil
    expect(subject).to_not be_valid
  end
  
  describe 'scopes' do
    context 'active' do
      let!(:admin_1) { create(:admin) }
      let!(:admin_2) { create(:admin, email: 'jdoe_admin@gmail.com', status: 'inactive') }
      
      it "should return active admins count" do
        expect(Admin.active.count).to eq(1)
      end  
    end
  end
end
