class AddFavoriteToArtworkShares < ActiveRecord::Migration[7.0]
  def change
    add_column :artwork_shares, :favorite, :boolean
  end
end
