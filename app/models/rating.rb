class Rating < ApplicationRecord

  validates :user_id, presence: true, uniqueness: { scope: [:level_id, :user_id] }, on: :create
  validates :level_id, presence: true, uniqueness: { scope: [:level_id, :user_id] }, on: :create
  validates :value, presence: true, numericality: {greater_than_or_equal_to: 0.0, less_than_or_equal_to: 5.0}
end
