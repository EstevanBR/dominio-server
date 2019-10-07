class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :level_id
end
