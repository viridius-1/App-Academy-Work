class ChangeUserIdToAuthorIdInLikes < ActiveRecord::Migration[7.0]
  def change
    remove_column :likes, :user_id
    add_column :likes, :author_id, :integer, null: false, default: 0
  end
end
