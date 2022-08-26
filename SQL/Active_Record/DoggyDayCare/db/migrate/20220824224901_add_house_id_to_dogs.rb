class AddHouseIdToDogs < ActiveRecord::Migration[5.2]
  def change
    add_column :dogs, :house_id, :integer, null: false
  end
end
