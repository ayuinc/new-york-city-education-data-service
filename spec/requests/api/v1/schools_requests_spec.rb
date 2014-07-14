require 'rails_helper'

describe 'api/v1/schools' do

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

    let(:search_request) do
      School.stub(:near).and_return([school])
      get "/api/v1/schools/search_by_address",
        { address: "333 East 4 Street" },
        { 'Accept' => Mime::JSON.to_s }
    end

    it "should be valid" do
      search_request
      expect(response.status).to eq(200)
    end

    it "sends params to School" do
      School.should_receive(:near).with("333 East 4 Street, New York City", 2)
      search_request
    end

    it "should return school" do
      search_request
      schools = School.all.map{ |f| SchoolSerializer.new(f) }.to_json
      expect(response.body).to eq(schools)
    end
  end
end
