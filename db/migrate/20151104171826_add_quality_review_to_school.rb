class AddQualityReviewToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :quality_review, :string
  end
end
