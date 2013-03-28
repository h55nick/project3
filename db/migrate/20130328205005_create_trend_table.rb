class CreateTrendTable < ActiveRecord::Migration
def change
  create_table :trends do |t|
    t.string :wages
    t.string :growth
    t.string :openings
    t.string :industries
    t.integer :career_id
    t.timestamps
  end
end
end
