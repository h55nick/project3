class CreateZonesTable < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.string :title
      t.text :education
      t.text :experience
      t.text :training
      t.timestamps
    end
  end
end
