require 'rails_helper'

RSpec.describe School, :type => :model do
  describe 'relations' do
    it { should have_many(:api_school_datas) }
    it { should have_many(:school_datas) }
  end
end
