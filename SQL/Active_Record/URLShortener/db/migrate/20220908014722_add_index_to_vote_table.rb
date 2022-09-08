class AddIndexToVoteTable < ActiveRecord::Migration[5.2]
  def change
    add_index :votes, [:user_id, :shortened_url_id]
  end
end
