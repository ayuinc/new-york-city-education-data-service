module NewYorkEducation
  class CheckData

    attr_accessor :report

    def self.generate_report_from(start, finish)
      @report = {}
      start.upto(finish) do |i|
        record_comparison(i)
      end
      puts @report.keep_if { |key, value| value == false }
    end

    def self.record_comparison(record_id)
      @api_data = ApiSchoolData.find(record_id)
      @csv_data = SchoolData.find(record_id)
      generate_report
    end

    def self.records_identical?(record_one, record_two)
      record_one_attributes = record_one.attributes
      record_two_attributes= record_two.attributes
      responses = []
      record_one_attributes.each do |key, value|
        unless record_two_attributes[key] == value || record_two_attributes[key].try(:to_i) == value.try(:to_i) || record_two_attributes[key].blank?
          responses << false
        else
          responses << true
        end
      end
      !responses.include?(false)
    end

    def self.generate_report
      @report[@api_data.id] = records_identical?(@api_data, @csv_data)
    end
  end
end
