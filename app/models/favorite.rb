class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :level

  validates :user_id, presence: true, uniqueness: { scope: [:level_id, :user_id] }, on: :create
  validates :level_id, presence: true, uniqueness: { scope: [:level_id, :user_id] }, on: :create

  def level
    Level.find(level_id)
  end

  def user
    User.find(user_id)
  end
end
