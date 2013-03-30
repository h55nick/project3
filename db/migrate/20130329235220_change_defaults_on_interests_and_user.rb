class ChangeDefaultsOnInterestsAndUser < ActiveRecord::Migration
  change_column :interests, :realistic, :integer, default: 0
  change_column :interests, :investigative, :integer, default: 0
  change_column :interests, :artistic, :integer, default: 0
  change_column :interests, :social, :integer, default: 0
  change_column :interests, :enterprising, :integer, default: 0
  change_column :interests, :conventional, :integer, default: 0
  change_column :users, :total, :integer, default: 0
end
