namespace :data_test do
  desc "Compare API with CSV data"
  task run: :environment do
    NewYorkEducation::DataTest.new.generate_report
  end
end
