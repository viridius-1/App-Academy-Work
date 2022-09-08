class AddUserIdIndexToShortenedUrlTable < ActiveRecord::Migration[5.2]
  def change
    add_index :shortened_urls, :user_id
  end
end
