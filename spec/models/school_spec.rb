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
end
