require 'rails_helper'

RSpec.describe SchoolData, :type => :model do
  context 'schema' do
    it { should have_db_column(:dbn) }
  end

  describe 'relations' do
    it { should belong_to(:school) }
  end
end
