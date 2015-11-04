class AddClosingGapToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :closing_gap, :string
  end
end
