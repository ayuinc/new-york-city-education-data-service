namespace :nyc_data do

  desc "Import data from CSV and generate school data with yearly information"
  task import: :environment do
    Rake::Task["nyc_data:create_schools"].invoke
  end

  desc "Create schools"
  task create_schools: :environment do
    NycData.create_schools
  end
end
