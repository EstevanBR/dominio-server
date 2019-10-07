class AddRatingsCountAndFavoritesCountToLevels < ActiveRecord::Migration[5.1]
  def change
    add_column :levels, :rating, :float, default: 0.00
  end
end
