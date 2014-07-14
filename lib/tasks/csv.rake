namespace :csv do

  desc "Populate database with school data"
  task import: :environment do
    Rake::Task["csv:schools"].invoke
    Rake::Task["csv:school_data"].invoke
  end

  desc "Export data to csv"
  task export: :environment do
    Rake::Task["csv:school_geolocation_data"].invoke
  end

  #desc "Export school geolocation data"
  #task school_geolocation_data: :environemtn do
    #my_file = "#{Rails.root}/lib/csv/schools.csv"
    #File.delete(my_file)
    #File.open(my_file, 'w')
  #end

  desc "Generate schools"
  task schools: :environment do

    schools = File.open("#{Rails.root}/lib/csv/schools.csv")

    csv_to_relational_db(schools, School)
  end

  desc "Generate school data"
  task school_data: :environment do

    school_data = File.open("#{Rails.root}/lib/csv/school_year_data.csv")

    csv_to_relational_db(school_data, SchoolData)
    create_school_data_association
  end


  def csv_to_relational_db(file, model)
    ActiveRecord::Base.transaction do
      CSV.foreach(file, headers: true) do |row|
        model.create!(row.to_hash)
      end
    end
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
