class AddFavoriteToArtwork < ActiveRecord::Migration[7.0]
  def change
    add_column :artworks, :favorite, :boolean
  end
end
