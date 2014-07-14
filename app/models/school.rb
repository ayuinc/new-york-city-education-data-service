class School < ActiveRecord::Base

  has_many :school_datas
  has_many :api_school_datas

  include PgSearch
  pg_search_scope :search_by_name_or_dbn, against: [:name, :dbn]

  geocoded_by :full_street_address
  after_validation :geocode, if: :primary_address_changed?

  scope :nearby_schools, ->(address, distance) { near(([address.to_s, "New York City"].compact.join(", ")), distance) }

  def full_street_address
    [primary_address, city, zip].compact.join(', ')
  end
end
