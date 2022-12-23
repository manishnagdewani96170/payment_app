module Merchants
  class DeleteUc
    def initialize(delete_service: Merchants::Delete.new)
      @delete_service = delete_service
    end

    def execute(merchant:)
      @delete_service.execute(merchant: merchant)
    end
  end
end