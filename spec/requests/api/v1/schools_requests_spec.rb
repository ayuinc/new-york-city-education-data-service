require 'rails_helper'

describe 'api/v1/schools' do

  before(:each) do
    School.stub(:geocode)
    School.stub(:near)
  end

  describe "GET '/api/v1/schools/search_by_address'" do

    let!(:school) do
      create(:school,
             primary_address: "333 EAST 4 STREET", 
             city: "MANHATTAN", 
             zip: "10009", 
             latitude: 40.721868, 
             longitude: -73.9787712
            )
    end

    let(:search_by_address_request) do
      School.stub(:near).and_return([school])
      get "/api/v1/schools/search_by_address",
        { address: "333 East 4 Street" },
        { 'Accept' => Mime::JSON.to_s }
    end

    it "should be valid" do
      search_by_address_request
      expect(response.status).to eq(200)
    end

    it "sends params to School" do
      School.should_receive(:near).with("333 East 4 Street, New York City", 2)
      search_by_address_request
    end

    it "should return school" do
      search_by_address_request
      schools = School.all.map{ |f| SchoolSerializer.new(f) }.to_json
      expect(response.body).to eq(schools)
    end
  end

  describe "GET '/api/v1/schools/search_by_name_or_dbn'" do

    it "should be valid" do
      create(:school)
      get "/api/v1/schools/search_by_name_or_dbn",
        { name_or_dbn: "PS 3" },
        { 'Accept' => Mime::JSON.to_s }

      expect(response.status).to eq(200)
    end

    it "should return the school" do
      school = create(:school, name: "P.S. 003 Charrette School")
      expected_schools = School.all.map{ |f| SchoolSerializer.new(f) }.to_json

      get "/api/v1/schools/search_by_name_or_dbn",
        { name_or_dbn: school.name },
        { 'Accept' => Mime::JSON }

      expect(response.body).to eq(expected_schools)
    end

    it "should return ps3" do
      create(:school, name: "P.S. 003 Charrette School")
      expected_schools = School.all.map{ |f| SchoolSerializer.new(f) }.to_json

      get "/api/v1/schools/search_by_name_or_dbn",
        { name_or_dbn: 'ps3' },
        { 'Accept' => Mime::JSON }

      expect(response.body).to eq(expected_schools)
    end
    
    it "should downcase and strip" do
      School.should_receive(:search_by_name_or_dbn).with("ps 003").ordered
      School.should_receive(:search_by_name_or_dbn).with("PS 3").ordered
      get "/api/v1/schools/search_by_name_or_dbn",
        { name_or_dbn: "PS 3" },
        { 'Accept' => Mime::JSON.to_s }
    end

    it "should add two zeros" do
      School.should_receive(:search_by_name_or_dbn).with("ps 003").ordered
      School.should_receive(:search_by_name_or_dbn).with("ps3").ordered
      get "/api/v1/schools/search_by_name_or_dbn",
        { name_or_dbn: 'ps3' },
        { 'Accept' => Mime::JSON.to_s }
    end

    it "should add one zero" do
      School.should_receive(:search_by_name_or_dbn).with("ps 030").ordered
      School.should_receive(:search_by_name_or_dbn).with("ps30").ordered
      get "/api/v1/schools/search_by_name_or_dbn",
        { name_or_dbn: 'ps30' },
        { 'Accept' => Mime::JSON.to_s }
    end

    it "should not add a zero" do
      School.should_receive(:search_by_name_or_dbn).with("ps 300").ordered
      School.should_receive(:search_by_name_or_dbn).with("ps300").ordered
      get "/api/v1/schools/search_by_name_or_dbn",
        { name_or_dbn: 'ps300' },
        { 'Accept' => Mime::JSON.to_s }
    end

    it "should add two zeros for jhs" do
      School.should_receive(:search_by_name_or_dbn).with("jhs 003").ordered
      School.should_receive(:search_by_name_or_dbn).with("jhs3").ordered
      get "/api/v1/schools/search_by_name_or_dbn",
        { name_or_dbn: 'jhs3' },
        { 'Accept' => Mime::JSON.to_s }
    end

    it "should add two zeros for ms" do
      School.should_receive(:search_by_name_or_dbn).with("ms 003").ordered
      School.should_receive(:search_by_name_or_dbn).with("ms3").ordered
      get "/api/v1/schools/search_by_name_or_dbn",
        { name_or_dbn: 'ms3' },
        { 'Accept' => Mime::JSON.to_s }
    end

    it "should add two zeros for is" do
      School.should_receive(:search_by_name_or_dbn).with("is 003").ordered
      School.should_receive(:search_by_name_or_dbn).with("is3").ordered
      get "/api/v1/schools/search_by_name_or_dbn",
        { name_or_dbn: 'is3' },
        { 'Accept' => Mime::JSON.to_s }
    end
  end
end
