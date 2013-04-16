class AddLinkTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :l_token, :string
  end
end
