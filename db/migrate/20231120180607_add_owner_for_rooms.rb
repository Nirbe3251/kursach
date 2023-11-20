class AddOwnerForRooms < ActiveRecord::Migration[7.0]
  def up
    add_reference :rooms, :user, null: false, foreign_key: true
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
  def def
    remove_reference :rooms, :user, foreign_key: true
  end
end
