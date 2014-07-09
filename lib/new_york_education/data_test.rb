module NewYorkEducation
  class DataTest

    attr_accessor :report

    def initialize
      @failures = []
    end

    def generate_report
      1.upto(ApiSchoolData.count) { |i| compare_records(i) }
      NewYorkEducation::ReportGenerator.new(@failures)
    end

    private

    def compare_records(record_id)
      api_data = ApiSchoolData.find(record_id)
      csv_data = SchoolData.find(record_id)
      @failures << api_data.id unless records_identical?(api_data, csv_data)
    end

    def records_identical?(record_one, record_two)
      record_one_attributes = record_one.attributes
      record_two_attributes= record_two.attributes
      responses = []
      record_one_attributes.each do |key, value|
       responses << false unless record_two_attributes[key] == value || record_two_attributes[key].try(:to_i) == value.try(:to_i) || record_two_attributes[key].blank?
      end
      !responses.include?(false)
    end
  end
end
