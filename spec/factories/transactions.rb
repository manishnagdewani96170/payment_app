FactoryBot.define do
  factory :transaction do
    uuid { Faker::Base.bothify('???-###') }
    customer_email { 'john_a@gmail.com' }
    customer_phone { '9090909090' }
    amount { 100.0 }
    status { 'approved' }
    merchant
  end

  factory :authorize_transaction, parent: :transaction, class: 'AuthorizeTransaction' do
  end

  factory :charge_transaction, parent: :transaction, class: 'ChargeTransaction' do
  end

  factory :refund_transaction, parent: :transaction, class: 'RefundTransaction' do
  end

  factory :reversal_transaction, parent: :transaction, class: 'ReversalTransaction' do
  end
end
