class CreateInterestsTable < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :t3
      t.integer :social
      t.integer :investigative
      t.integer :realistic
      t.integer :enterprising
      t.integer :conventional
      t.integer :artistic
      t.integer :career_id
      t.integer :user_id
      t.timestamps
    end
  end
end
