class AddIndexToUserIdLikesTable < ActiveRecord::Migration[7.0]
  def change
    add_index :likes, :user_id 
  end
end
