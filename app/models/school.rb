class School < ActiveRecord::Base

  has_many :school_datas
  has_many :api_school_datas

  before_save :strip_punctuation

  include PgSearch
  pg_search_scope :search_by_name_or_dbn,
    against: [:name, :dbn],
    using: { 
      tsearch: { prefix: true }
    }

  scope :nearby_schools, ->(address, distance) { near(([address.to_s, "New York City"].compact.join(", ")), distance) }

  def full_street_address
    [primary_address, city, zip].compact.join(', ')
  end

  private

  def strip_punctuation
    self.name = self.name.gsub(/[^a-z0-9\s]/i, '')
  end
end
