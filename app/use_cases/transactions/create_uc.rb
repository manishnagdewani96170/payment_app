module Transactions
  class CreateUc
    def initialize(create_service: Transactions::Create.new)
      @create_service = create_service
    end

    def execute(params:)
      @create_service.execute(params: params)
    end
  end
end