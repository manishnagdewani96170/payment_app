module Merchants
  class UpdateUc
    def initialize(update_service: Merchants::Update.new)
      @update_service = update_service
    end

    def execute(merchant:, params:)
      @update_service.execute(merchant: merchant, params: params)
    end
  end
end