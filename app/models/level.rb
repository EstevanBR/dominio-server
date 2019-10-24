class LevelValidator < ActiveModel::Validator
  def validate(level)
    level.errors[:data] << "Expected 1 Entrance" unless level.data.dig("ENTRANCE").count == 1
    level.errors[:data] << "Expected 1 Entrance" unless level.data.dig("EXIT").count == 1
  end
end

class Level < ApplicationRecord
  belongs_to :user
  validates_with LevelValidator

  has_many :ratings, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :data, presence: true
  validates :name, presence: true
  validates :user_id, presence: true

  def update_ratings!
    rating = ratings.calculate(:average, :value)
    save!
  end
end
