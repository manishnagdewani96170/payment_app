module Merchants
  class Update

    def execute(merchant:, params:)
      merchant.update(params)
      merchant
    end
  end
end
