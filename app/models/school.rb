class School < ActiveRecord::Base

  include PgSearch
  pg_search_scope :search_by_name_or_dbn, 
    against: [:name, :dbn], 
    using: { tsearch: { prefix: true } }

  geocoded_by :full_street_address

  has_many :school_datas
  has_many :api_school_datas

  before_save :strip_punctuation
  after_validation :geocode, if: :primary_address_changed?


  scope :nearby_schools, ->(address, distance) do
    near(([address.to_s, "New York City"].compact.join(", ")), distance) 
  end

  scope :search_results, ->(search_params) do
    @search_params = search_params
    search_with_filter
      .zip(search_without_filter)
      .flatten
      .first(30)
      .compact
      .uniq
  end

  def full_street_address
    [primary_address, city, zip].compact.join(', ')
  end

  private

  def self.search_with_filter
    filtered_phrase = SearchFilter.new(@search_params).filter
    self.search_by_name_or_dbn(filtered_phrase) || []
  end

  def self.search_without_filter
    self.search_by_name_or_dbn(@search_params) || []
  end

  def strip_punctuation
    self.name = self.name.gsub(/[^a-z0-9\s]/i, '')
  end
end
