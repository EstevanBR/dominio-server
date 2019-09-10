class Level < ApplicationRecord
  belongs_to :user

  validates :data, presence: true
  validates :name, presence: true
  validates :user_id, presence: true
end
