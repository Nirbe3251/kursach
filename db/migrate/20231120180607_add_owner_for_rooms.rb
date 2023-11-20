class AddOwnerForRooms < ActiveRecord::Migration[7.0]
  def up
<<<<<<< HEAD
    add_reference :rooms, :user, references: :owner, null: false, foreign_key: true
    add_column :rooms, :name, :string, default: ''
    add_column :rooms, :password, :string, default: ''
    add_column :rooms, :status, :boolean, null: false, default: false
  end
  def def
    remove_reference :rooms, :user, foreign_key: true
    remove_column :rooms, :name
    remove_column :rooms, :password
    remove_column :rooms, :status
=======
    add_reference :rooms, :user, null: false, foreign_key: true
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
  def def
    remove_reference :rooms, :user, foreign_key: true
>>>>>>> room destroy add
  end
end
