class School < ActiveRecord::Base
  has_many :school_datas
  has_many :api_school_datas

  geocoded_by :full_street_address
  after_validation :geocode, if: :primary_address_changed?

  scope :nearby_schools, ->(address, distance){ near(([address.to_s, "New York City"].compact.join(", ")), distance) }

  def full_street_address
    [primary_address, city, zip].compact.join(', ')
  end
end
