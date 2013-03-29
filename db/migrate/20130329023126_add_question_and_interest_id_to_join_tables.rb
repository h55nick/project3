class AddQuestionAndInterestIdToJoinTables < ActiveRecord::Migration
  def change
    add_column :interests, :question_id, :integer
    add_column :questions, :interest_id, :integer
  end
end
