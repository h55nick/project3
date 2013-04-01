class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.text :url
      t.string :name
      t.text :description
      t.string :company
      t.string :location
      t.date :deadline
      t.string :website
      t.float :lat
      t.float :lon
      t.boolean :completed, default: false
      t.integer :user_id
      t.timestamps
    end
  end
end
