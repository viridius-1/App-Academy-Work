class CreateCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :collections do |t|
      t.integer :user_id, null: false
      t.integer :artwork_id, null: false 
      t.string :name, null: false 

      t.timestamps
    end

    add_index :collections, :user_id
    add_index :collections, :name
  end
end
