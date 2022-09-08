class AddIndexToTaggingTable < ActiveRecord::Migration[5.2]
  def change
    add_index :taggings, [:user_id, :shortened_url_id, :tag_topic_id]
  end
end
