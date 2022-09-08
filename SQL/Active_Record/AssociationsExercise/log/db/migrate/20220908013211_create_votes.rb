class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :user_id, null: false 
      t.integer :shortened_url_id, null: false 
      t.integer :votes, default: 0 

      t.timestamps 
    end
  end
end
