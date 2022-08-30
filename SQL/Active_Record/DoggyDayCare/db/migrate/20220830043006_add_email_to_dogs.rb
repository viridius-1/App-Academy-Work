class AddEmailToDogs < ActiveRecord::Migration[5.2]
  def change
    add_column :dogs, :email, :string, null: false
    remove_column :dogs, :email
  end
end
