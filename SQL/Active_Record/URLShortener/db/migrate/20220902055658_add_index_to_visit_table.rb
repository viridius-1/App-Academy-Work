class AddIndexToVisitTable < ActiveRecord::Migration[5.2]
  def change
    add_index :visits, :user_id
    add_index :visits, :shortened_url_id
  end
end
