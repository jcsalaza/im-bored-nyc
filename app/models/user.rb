class User < ActiveRecord::Base
  has_many :user_events
  has_many :events, through: :user_events

  has_secure_password

  validates :name, :username, :email, :password, presence: :true
  validates :username, :email, uniqueness: :true, on: :create
  validates :password, length: {minimum: 8, message: 'Must be at least 8 characters.'}
end
