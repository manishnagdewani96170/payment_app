module API::V1::Entities
  class MerchantEntity < Grape::Entity
    expose :id
    expose :name
    expose :email
    expose :status
    expose :total_transaction_sum
  end
end
