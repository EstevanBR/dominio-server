class LevelSerializer < ActiveModel::Serializer
  attributes :id, :data, :name, :user_id, :rating

  def rating
    object.ratings.calculate(:average, :value)
  end
end
