class School < ActiveRecord::Base

  has_many :school_datas
  has_many :api_school_datas

  before_save :downcase_and_strip

  include PgSearch
  pg_search_scope :search_by_name_or_dbn,
    against: [:name, :dbn],
    using: { 
      tsearch: { prefix: true }
    }

  geocoded_by :full_street_address
  after_validation :geocode, if: :primary_address_changed?

  scope :nearby_schools, ->(address, distance) { near(([address.to_s, "New York City"].compact.join(", ")), distance) }

  def full_street_address
    [primary_address, city, zip].compact.join(', ')
  end

  private

  def downcase_and_strip
    self.name = self.name.downcase.gsub(/[^a-z0-9\s]/i, '')
  end
end
