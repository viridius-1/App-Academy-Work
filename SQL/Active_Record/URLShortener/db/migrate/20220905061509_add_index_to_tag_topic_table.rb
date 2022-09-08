class AddIndexToTagTopicTable < ActiveRecord::Migration[5.2]
  def change
    add_index :tag_topics, :tag_topic, unique: true
  end
end
