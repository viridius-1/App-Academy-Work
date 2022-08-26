class AddIndexToDogTable < ActiveRecord::Migration[5.2]
  def change
      add_index :dogs, :name
  end
end
