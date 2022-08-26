class AddIndexToDogTable < ActiveRecord::Migration[5.2]
  def change
      add_index :dogs, :name, { unique: true }
  end
end
