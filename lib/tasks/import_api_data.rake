namespace :api_data do

  desc "Import data from server"
  task import: :environment do
    1.upto(School.count) do |i|
      NewYorkEducation::ApiRecord.new(i).save
    end
  end
end
