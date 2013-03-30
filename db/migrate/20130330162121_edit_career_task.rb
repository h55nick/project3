class EditCareerTask < ActiveRecord::Migration
  def change
    remove_column :careers, :task_id
    add_column :careers, :tasks, :text
  end
end

