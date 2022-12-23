module Merchants
  class EditForm

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
      true
    end

    def initialize(merchant:, params: {}, update_use_case: Merchants::UpdateUc.new)
      super(params)
      @merchant = merchant
      @update_use_case = update_use_case
      promote_attributes if params.empty?
    end

    def submit
      return false if invalid?

      merchant = @update_use_case.execute(merchant: @merchant, params: merchant_params)
    
      unless merchant.errors.empty?
        promote_errors(merchant.errors)
        return false
      end

      true
    end

    private

    def promote_attributes
      self.name = @merchant.name
      self.email = @merchant.email
      self.status = @merchant.status
      self.description = @merchant.description 
    end

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