class AddBodyToCommentsTable < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :body, :text, null: false 
  end
end
