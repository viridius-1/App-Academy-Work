class CreateTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :taggings do |t|
      t.integer :user_id, null: false
      t.integer :tag_topic_id, null: false 
      t.integer :shortened_url_id, null: false 
    end
  end
end
