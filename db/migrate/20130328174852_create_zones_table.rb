class CreateZonesTable < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.string :title
      t.text :education
      t.text :experience
      t.text :training
      t.integer :career_id
      t.timestamps
    end
  end
end
