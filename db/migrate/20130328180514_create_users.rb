class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first
      t.string :last
      t.string :email
      t.string :password_digest
      t.string :location
      t.integer :lat
      t.integer :lon
      t.string :education
      t.timestamps
    end
  end
end
