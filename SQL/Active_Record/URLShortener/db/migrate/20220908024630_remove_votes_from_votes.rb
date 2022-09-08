class RemoveVotesFromVotes < ActiveRecord::Migration[5.2]
  def change
    remove_column :votes, :votes
  end
end
