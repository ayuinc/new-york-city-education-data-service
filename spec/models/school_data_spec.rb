require 'rails_helper'

RSpec.describe SchoolData, :type => :model do
  describe 'relations' do
    it { should belong_to(:school) }
  end
end
