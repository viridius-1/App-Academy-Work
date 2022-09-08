class ShortenedUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :shortened_urls do |t|
      t.string :long_url 
      t.string :short_url
      t.integer :user_id 

      t.timestamps
    end 
  end
end
