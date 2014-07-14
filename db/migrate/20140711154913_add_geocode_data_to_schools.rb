class AddGeocodeDataToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :primary_address, :string
    add_column :schools, :city, :string
    add_column :schools, :zip, :string
    add_column :schools, :latitude, :float
    add_column :schools, :longitude, :float
  end
end
