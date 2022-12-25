require 'rails_helper'

RSpec.describe DeleteOldTransactions, type: :job do
  subject { described_class.new }

  it "should perform given job" do
    subject.perform
  end
end