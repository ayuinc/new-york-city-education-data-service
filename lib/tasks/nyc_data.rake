namespace :nyc_data do

  desc "Import data from CSV and generate school data with yearly information"
  task import: :environment do
    Rake::Task["nyc_data:create_schools"].invoke
    Rake::Task["nyc_data:school_data"].invoke
    Rake::Task["nyc_data:generate_dbn_data"].invoke
  end

  desc "Create schools"
  task create_schools: :environment do
    NycData.create_schools
  end

  desc "Generate school data"
  task generate_dbn_data: :environment do
    schools = School.all
    schools.each do |school|
      school.dbn_id = school.dbn[3..5]
      school.save
    end
  end

  desc "Export data to csv"
  task export: :environment do
    Rake::Task["csv:school_data"].invoke
  end

  desc "Generate school data"
  task school_data: :environment do

    school_data = File.open("#{Rails.root}/lib/csv/school_year_data.csv")

    csv_to_relational_db(school_data, SchoolData)
    create_school_data_association
  end


  def create_school_data_association
    school_id_array = []
    1.upto(School.count) do |i|
      4.times { school_id_array << i }
    end
    1.upto(SchoolData.count) do |i|
      school_data = SchoolData.find(i)
      school_data.school_id = school_id_array[i - 1]
      school_data.save
    end
  end
end
