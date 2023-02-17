class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :author_id, null: false 
      t.integer :artwork_id, null: false 

      t.timestamps
    end

    add_index :comments, :author_id 
    add_index :comments, :artwork_id 
  end
end
