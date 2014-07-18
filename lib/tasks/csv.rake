namespace :csv do

  desc "Populate database with school data"
  task import: :environment do
    Rake::Task["csv:create_schools"].invoke
    Rake::Task["csv:school_data"].invoke
  end

  desc "Export data to csv"
  task export: :environment do
    Rake::Task["csv:school_data"].invoke
  end

  desc "Export school geolocation data"
  task school_data: :environment do
    my_file = "#{Rails.root}/lib/csv/schools.csv"
    schools = School.all.order('id')
    File.delete(my_file)
    CSV.open(my_file, 'w') do |writer|
      writer << ["dbn", "name", "primary_address", "city", "zip", "latitude", "longitude"]
      schools.each do |s|
        writer << [s.dbn, s.name, s.primary_address, s.city, s.zip, s.latitude, s.longitude]
      end
    end
  end

  desc "Generate schools"
  task create_schools: :environment do

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
    CSV.foreach(file, headers: true) do |row|
      record = model.new(row.to_hash)
      record.save
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
