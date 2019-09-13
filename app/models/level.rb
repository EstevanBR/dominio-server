class Level < ApplicationRecord
  belongs_to :user

  has_many :ratings, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :data, presence: true
  validates :name, presence: true
  validates :user_id, presence: true
end
