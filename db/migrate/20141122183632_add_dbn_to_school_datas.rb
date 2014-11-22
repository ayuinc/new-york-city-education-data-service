class AddDbnToSchoolDatas < ActiveRecord::Migration
  def change
    add_column :school_data, :dbn, :string
  end
end
