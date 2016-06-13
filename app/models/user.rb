class User < ActiveRecord::Base
  has_secure_password

  has_many :images, dependent: :destroy
  has_many :sessions, dependent: :destroy
  has_many :tasks, dependent: :destroy
  validates :email, uniqueness: true, presence: true
end
