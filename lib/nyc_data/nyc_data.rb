class NycData

  def self.create_schools
    import_school_csv(school_csv, School)
  end

  private

  def school_csv
    @school_csv ||= File.open("#{Rails.root}/lib/csv/schools.csv")
  end

  def import_school_csv(file, model)
    CSV.foreach(file, headers: true) do |row|
      record = model.new(row.to_hash)
      record.save
    end
  end
end
