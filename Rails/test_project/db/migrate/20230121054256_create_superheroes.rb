class CreateSuperheroes < ActiveRecord::Migration[7.0]
  def change
    create_table :superheroes do |t|
      t.string :name, null: false 
      t.string :secret_identity, null: false 
      t.integer :power, null: false 
      
      t.timestamps
    end
  end
end
