class CreateMessages < ActiveRecord::Migration[7.0]
  def up
    create_table :messages do |t|
      t.text :body
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
  def down
    drop_table :messages
  end
end
