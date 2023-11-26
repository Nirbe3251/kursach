class AddUsersToRooms < ActiveRecord::Migration[7.0]
  def up
    create_table :room_users do |t|
      t.belongs_to :room
      t.belongs_to :user
      
      t.timestamps
    end
  end
  def down
    drop_table :room_users
  end
end
