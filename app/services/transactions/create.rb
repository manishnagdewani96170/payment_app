module Transactions
  class Create

    def execute(params:)
      transaction = Transaction.create(params)
      transaction
    end
  end
end
