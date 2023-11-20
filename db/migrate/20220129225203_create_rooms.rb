class CreateRooms < ActiveRecord::Migration[7.0]
  def up
    create_table :rooms do |t|
      t.string :token

      t.timestamps
    end
  end
  def def down 
    drop_table :rooms
  end
end
