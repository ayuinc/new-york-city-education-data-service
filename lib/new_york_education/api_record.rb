require 'net/http'
require 'json'

module NewYorkEducation

  class ApiRecord

    def initialize(school_id)
      @school_id = school_id.to_s
    end

    def save
      schools_data_array.each do |school_data|
        ApiSchoolData.create!(school_data)
      end
    end

    private

    def schools_data_array
      NewYorkEducation::JsonToValidRecord.new(school_records).valid_records
    end

    def school_records
      NewYorkEducation::ApiJsonParser.new(@school_id).records
    end
  end
end
