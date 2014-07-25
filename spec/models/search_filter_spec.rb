require 'rails_helper'

RSpec.describe SearchFilter, type: :model do

  describe 'filter' do

    it 'should downcase and strip' do
      phrase = SearchFilter.new('P.S. 003 Charrette School').filter
      expect(phrase).to eq('ps 003 charrette school')
    end

    describe 'spaces' do
      it 'should add spaces for ps schools that are mashed together' do
        phrase = SearchFilter.new('psschool').filter
        expect(phrase).to eq('ps school')
      end

      it 'should add spaces for ms schools that are mashed together' do
        phrase = SearchFilter.new('msschool').filter
        expect(phrase).to eq('ms school')
      end

      it 'should add spaces for is schools that are mashed together' do
        phrase = SearchFilter.new('isschool').filter
        expect(phrase).to eq('is school')
      end

      it 'should add spaces for jhs schools that are mashed together' do
        phrase = SearchFilter.new('jhsschool').filter
        expect(phrase).to eq('jhs school')
      end
    end

    describe 'add zeros' do

      it "should not add zeros for ps schools with 3 digits" do
        phrase = SearchFilter.new('ps030').filter
        expect(phrase).to eq('ps 030')
      end

      it "should add one zero for ps schools with 2 digits" do
        phrase = SearchFilter.new('ps30').filter
        expect(phrase).to eq('ps 030')
      end

      it "should add two zeros for ps schools with 1 digits" do
        phrase = SearchFilter.new('ps3').filter
        expect(phrase).to eq('ps 003')
      end

      it "should not add zeros for jhs schools with 3 digits" do
        phrase = SearchFilter.new('jhs030').filter
        expect(phrase).to eq('jhs 030')
      end

      it "should add one zero for jhs schools with 2 digits" do
        phrase = SearchFilter.new('jhs30').filter
        expect(phrase).to eq('jhs 030')
      end

      it "should add two zeros for jhs schools with 1 digits" do
        phrase = SearchFilter.new('jhs3').filter
        expect(phrase).to eq('jhs 003')
      end
    end
  end
end
