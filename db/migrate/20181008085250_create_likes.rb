class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :note_id

      t.timestamps
    end
    add_index :likes, :user_id
    add_index :likes, :note_id
    add_index :likes, [:user_id,:note_id],unique:true
  end
end
