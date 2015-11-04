class AddAttendanceCategoryToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :attendance_category, :string
  end
end
