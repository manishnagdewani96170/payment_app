module API::V1::Entities
  class TransactionEntity < Grape::Entity
    expose :id
    expose :uuid
    expose :customer_email
    expose :customer_phone
    expose :amount

    expose :merchant, using: API::V1::Entities::MerchantEntity do |transaction, options|
      transaction.merchant
    end
  end
end
