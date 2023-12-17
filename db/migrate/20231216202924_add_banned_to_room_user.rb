class AddBannedToRoomUser < ActiveRecord::Migration[7.0]
  def up
    add_column :room_users, :banned, :boolean, default: false
  end
  def down
    remove_column :room_users, :banned
  end
end
