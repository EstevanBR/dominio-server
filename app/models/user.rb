class User < ApplicationRecord
  has_secure_password

  has_many :levels, dependent: :destroy
  has_many :ratings, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
end
