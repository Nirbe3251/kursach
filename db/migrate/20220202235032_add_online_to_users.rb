class AddOnlineToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :online, :boolean, null: false, default: false
  end
  def def down 
    remove_column :users, :online
  end
end
