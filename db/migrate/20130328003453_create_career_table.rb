class CreateCareerTable < ActiveRecord::Migration
  def change
    create_table :careers do |t|
      t.string :code
      t.string :title
      t.string :zone
      t.integer :zone_id
      t.integer :task_id
      t.integer :tool_id
      t.integer :knowledge_id
      t.integer :skill_id
      t.integer :ability_id
      t.integer :activity_id
      t.integer :context_id
      t.timestamps
    end
  end
end
