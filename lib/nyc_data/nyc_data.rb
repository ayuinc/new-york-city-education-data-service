class NycData

  def self.create_schools
    import_csv(school_csv, School)
    import_csv(school_data_csv, SchoolData)
    create_school_data_association
    generate_dbn_data
  end

  private

  def self.school_csv
    @@school_csv ||= File.open("#{Rails.root}/lib/csv/schools.csv")
  end

  def self.school_data_csv
    @@school_data_csv ||= File.open("#{Rails.root}/lib/csv/school_year_data.csv")
  end

  def self.import_csv(file, model)
    CSV.foreach(file, headers: true) do |row|
      row_hash = row.to_hash
      row_hash.each do |key, value|
        row_hash[key] = value.scrub! unless value.nil?
      end

      puts "Creating #{model} ...."
      puts row_hash
      record = model.new(row_hash)
      record.save
    end
  end

  def self.generate_dbn_data
    schools.each do |school|
      school.dbn_id = school.dbn[3..5]
      school.save
    end
  end

  def self.create_school_data_association
    school_id_array = []
    school_dbn_array = []
    1.upto(School.count) do |i|
      school = schools.find(i)
      4.times { school_id_array << school.id }
      4.times { school_dbn_array << school.dbn }
    end
    1.upto(SchoolData.count) do |i|
      school_data = school_datas.find(i)
      school_data.school_id = school_id_array[i - 1]
      school_data.dbn = school_dbn_array[i - 1]
      school_data.save
    end
  end

  def self.schools
    @@schools ||= School.order(:id)
  end

  def self.school_datas
    @@school_datas ||= SchoolData.order(:id)
  end
end
