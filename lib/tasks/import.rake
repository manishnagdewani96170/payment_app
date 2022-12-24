namespace :import do

  desc "Imports a CSV file into an ActiveRecord table"  
  task :csv_model_import, [:filepath, :model] => [:environment] do |task,args|
    Import::CsvImport.new(args[:filepath], args[:model]).execute
  end

end
