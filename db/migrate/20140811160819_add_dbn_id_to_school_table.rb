class AddDbnIdToSchoolTable < ActiveRecord::Migration
  def change
    add_column :schools, :dbn_id, :string
  end
end
