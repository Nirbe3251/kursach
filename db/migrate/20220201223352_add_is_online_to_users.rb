class AddIsOnlineToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :is_online, :boolean
  end
  def down 
    remove_column :users, :is_online
  end
end
