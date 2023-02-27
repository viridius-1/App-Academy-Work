class AddDatabaseConstraintUserIdPostIdToLikes < ActiveRecord::Migration[7.0]
  def change
    remove_column :likes, :user_id
    remove_column :likes, :post_id
    add_column :likes, :user_id, :integer, null: false, default: 0
    add_column :likes, :post_id, :integer, null: false, default: 0
  end
end
