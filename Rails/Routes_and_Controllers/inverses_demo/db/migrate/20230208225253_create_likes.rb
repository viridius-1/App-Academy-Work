class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer :author_id, null: false 
      t.integer :post_id, null: false 

      t.timestamps
    end
  end
end
