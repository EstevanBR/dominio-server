class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :level

  validates :user_id, presence: true, uniqueness: { scope: [:level_id, :user_id] }, on: :create
  validates :level_id, presence: true, uniqueness: { scope: [:level_id, :user_id] }, on: :create
  validates :value, presence: true, numericality: {greater_than_or_equal_to: 0.0, less_than_or_equal_to: 5.0}

  def level
    Level.find(level_id)
  end

  def user
    User.find(user_id)
  end
end
