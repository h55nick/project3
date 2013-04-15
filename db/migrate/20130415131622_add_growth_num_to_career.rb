class AddGrowthNumToCareer < ActiveRecord::Migration
  def change
        add_column :careers, :growth_num, :integer
  end
end
