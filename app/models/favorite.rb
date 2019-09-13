class Favorite < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: [:level_id, :user_id] }, on: :create
  validates :level_id, presence: true, uniqueness: { scope: [:level_id, :user_id] }, on: :create
end
