class User < ActiveRecord::Base
  validates :email, :password_confirmation, presence: true

  has_many :reviews
  has_many :products, through: :reviews
  has_secure_password     #magic for hash encryption and validation
end
