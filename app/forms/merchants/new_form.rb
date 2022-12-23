module Merchants
  class NewForm

    include ActiveModel::Model

    attr_accessor :id,
                  :name,
                  :email,
                  :status,
                  :description  

    validates_presence_of :name
    validates_presence_of :email
    validates_presence_of :status

    def persisted?
      false
    end

    def initialize(params: {}, create_use_case: Merchants::CreateUc.new)
      super(params)
      @create_use_case = create_use_case
    end

    def submit
      return false if invalid?

      merchant = @create_use_case.execute(params: merchant_params)
    
      unless merchant.errors.empty?
        promote_errors(merchant.errors)
        return false
      end

      true
    end

    private

    def merchant_params
      {
        name: @name,
        email: @email,
        status: @status,
        description: @description
      }  
    end

    def promote_errors(child_errors)
      child_errors.each do |attribute, message|
        errors.add(attribute, message)
      end
    end

  end
end