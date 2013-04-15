class AddGrowthNumToTrend < ActiveRecord::Migration
  def change
    add_column :trends, :growth_num, :integer
  end
end
