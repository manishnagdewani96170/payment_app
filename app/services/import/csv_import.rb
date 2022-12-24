require 'csv'
  
module Import  
  class CsvImport

    attr_reader :filepath, :model

    def initialize(filepath, model)
      @filepath = filepath
      @model    = model
    end
    
    def execute
      raise 'Invalid arguments passed' if !valid_model_class? || !valid_filepath?

      begin
        puts "*********Import Started*************"
        attributes = []
        
        CSV.foreach(filepath, :headers => true, :header_converters => lambda { |h| h.try(:downcase) }) do |row|
          puts "***********row :: #{row}**********"
          attributes << row.to_h
        end
        
        Module.const_get(model).create!(attributes)
        puts "*********Import Completed*************"

      rescue => e
        puts "************Exception:: #{e.message}*************"
      end
      
    end

    private

    def valid_model_class?
      Module.const_get(model).class == Class rescue false
    end

    def valid_filepath?
      File.exist?(filepath)
    end
  end
end
