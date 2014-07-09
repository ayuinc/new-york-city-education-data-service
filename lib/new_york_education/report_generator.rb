module NewYorkEducation
  class ReportGenerator
    def initialize(failures)
      @failures = failures
      @failures_count = failures.count
      @school_count = School.count
      @api_school_data_count = ApiSchoolData.count
      @school_data_count = SchoolData.count
      @total_records = @school_count + @api_school_data_count + @school_data_count
      generate_report
    end

    def generate_report
      report_file = "#{Rails.root}/report.md"
      File.delete(report_file)
      File.open(report_file, 'w') { |file| file.write(report_text)}
      puts report_text
    end

    def report_text
<<PARAGRAPH
Data Test Report
======

#{@school_count} schools

#{@total_records} school data records

#{@api_school_data_count} tests

#{@total_records - @failures_count} records validated

#{@failures_count} failures
PARAGRAPH
    end
  end
end
