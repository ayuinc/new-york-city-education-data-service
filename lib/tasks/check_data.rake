namespace :check_data do
  desc "Compare API with CSV data"
  task run: :environment do
    NewYorkEducation::CheckData.generate_report_from(1, ApiSchoolData.count)
  end
end
