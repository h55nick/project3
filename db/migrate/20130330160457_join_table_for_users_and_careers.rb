class JoinTableForUsersAndCareers < ActiveRecord::Migration
  def change
    create_table :careers_users, id: false do |j|
      j.integer :career_id
      j.integer :user_id
    end
  end
end
