class AddOwnerForRooms < ActiveRecord::Migration[7.0]
  def up
    add_reference :rooms, :user, references: :owner, null: false, foreign_key: true
    add_column :rooms, :name, :string, default: ''
    add_column :rooms, :password, :string, default: ''
    add_column :rooms, :private, :boolean, null: false, default: false
  end
  def def
    remove_reference :rooms, :user, foreign_key: true
    remove_column :rooms, :name
    remove_column :rooms, :password
    remove_column :rooms, :private
  end
end
