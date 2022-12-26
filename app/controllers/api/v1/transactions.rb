module API
  module V1
    class Transactions < Grape::API
      include API::V1::Defaults
      
      resource :transactions do

        http_basic do |username, password|
          result = username == ENV['USER_NAME'] && password == ENV['PASSWORD']
          result ? true : error!('401 Unauthorized', 401) 
        end
        
        desc "Create Transaction"
        
        params do
          requires :uuid, type: String, desc: "status"
          requires :status, type: String, desc: "status"
          optional :amount, type: Float, desc: "amount"
          requires :customer_email, type: String, desc: "customer_email"
          optional :customer_phone, type: String, desc: "customer_phone"
          requires :merchant_id, type: Integer, desc: "merchant_id"
          optional :customer_phone, type: String, desc: "customer_phone"
        end

        post do
          merchant = Merchant.find_by_id(permitted_params[:merchant_id])
          error!('Merchant not found', 404) unless merchant
          error!('Merchant is not active', 403) unless merchant.active?
      
          transaction = ::Transactions::CreateUc.new.execute(params: permitted_params)
          error!(transaction.errors.full_messages, 403) if transaction.errors.present?
          present transaction, with: API::V1::Entities::TransactionEntity
        end
      end
    end
  end
end