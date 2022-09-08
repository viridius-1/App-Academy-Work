class AddIndexToWordTable < ActiveRecord::Migration[5.2]
  def change
    add_index :words, :word
  end
end
