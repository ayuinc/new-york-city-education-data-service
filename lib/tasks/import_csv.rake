namespace :csv do

  desc "Populate database with school data"
  task import: :environment do
    Rake::Task["csv:schools"].invoke
  end

  desc "Generate school data"
  task schools: :environment do
    schools = File.open("#{Rails.root}/lib/csv/schools.csv")
    ActiveRecord::Base.transaction do
      CSV.foreach(schools, headers: true) do |row|
        School.find_or_create_by!(row.to_hash)
      end
    end
  end
end
