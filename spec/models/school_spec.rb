require 'rails_helper'

RSpec.describe School, :type => :model do
  describe 'relations' do
    it { should have_many(:api_school_datas) }
    it { should have_many(:school_datas) }
  end

  describe 'full_street_address' do

    let(:school) { create(:school) }

    it "should return full street address" do
      address = school.primary_address + ", " + school.city + ", " + school.zip
      expect(school.full_street_address).to eq(address)
    end
  end

  describe 'search_by_name_or_dbn' do

    let(:school) do
      create(:school,
             name: "School Name",
             dbn: "12345678"
            )
    end

    it "returns by dbn" do
      result = School.search_by_name_or_dbn(school.dbn)
      expect(result) == [school]
    end

    it "returns by name" do
      result = School.search_by_name_or_dbn(school.name)
      expect(result) == [school]
    end

    it "returns a partial name search" do
      result = School.search_by_name_or_dbn("School")
      expect result == [school]
    end

    it "returns a partial dbn search" do
      result = School.search_by_name_or_dbn("1234")
      expect result == [school]
    end

    it "should return multiple partial matches" do
      school_two = create(:school, name: "Second School Name")
      result = School.search_by_name_or_dbn("School")
      expect result == [school, school_two]
    end

    it "stills returns a unique result" do
      school_two = create(:school, name: "School Name Second ")
      result = School.search_by_name_or_dbn("Second")
      expect result == [school_two]
    end

    it "should disregard character case" do
      school_two = create(:school, name: "School Name Second ")
      result = School.search_by_name_or_dbn("SeCoNd")
      expect result == [school_two]
    end
  end
end
