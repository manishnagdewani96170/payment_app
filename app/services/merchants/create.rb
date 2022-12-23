module Merchants
  class Create

    def execute(params:)
      merchant = Merchant.create(params)
      merchant
    end
  end
end
