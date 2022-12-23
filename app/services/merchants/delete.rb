module Merchants
  class Delete

    def execute(merchant:)
      merchant.destroy
    end
  end
end