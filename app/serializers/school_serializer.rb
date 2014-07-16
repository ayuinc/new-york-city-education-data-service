class SchoolSerializer < ActiveModel::Serializer
  attributes :id, :name, :primary_address, :dbn
end
