module Merchants
  class CreateUc
    def initialize(create_service: Merchants::Create.new)
      @create_service = create_service
    end

    def execute(params:)
      @create_service.execute(params: params)
    end
  end
end