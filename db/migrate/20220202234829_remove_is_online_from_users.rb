class RemoveIsOnlineFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :is_online, :boolean
  end
end
