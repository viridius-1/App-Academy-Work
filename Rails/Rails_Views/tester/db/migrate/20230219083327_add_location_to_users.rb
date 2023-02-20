class AddLocationToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :location, :string, null: false
  end
end
