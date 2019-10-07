class LevelSerializer < ActiveModel::Serializer
  attributes :id, :data, :name, :user_id, :rating, :ratings, :favorites

  def rating
    object.ratings.calculate(:average, :value)
  end

  def ratings
    object.ratings.count
  end

  def favorites
    object.favorites.count
  end
end
