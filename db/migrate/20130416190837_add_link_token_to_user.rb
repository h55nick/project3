class AddLinkTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :l_token, :string
    add_column :users, :l_secret, :string
  end
end
