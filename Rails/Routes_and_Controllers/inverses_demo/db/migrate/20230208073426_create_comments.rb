class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :author_id, null: false 
      t.integer :post_id, null: false 
      t.string :title, null: false 
      t.string :body, null: false 

      t.timestamps
    end
  end
end
