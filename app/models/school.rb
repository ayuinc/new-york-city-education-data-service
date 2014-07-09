class School < ActiveRecord::Base
  has_many :school_datas
  has_many :api_school_datas
end
