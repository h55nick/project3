class QuestionAndUserJoinTable < ActiveRecord::Migration
  def change
    create_table :questions_users do |j|
      j.integer :user_id
      j.integer :question_id
    end
  end
end
