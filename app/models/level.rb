class Level < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :data, presence: true
  validates :name, presence: true
end
