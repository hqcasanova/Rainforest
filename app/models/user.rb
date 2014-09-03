class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, 
    format: { with: /\A[A-Za-z\d_]*\Z/, message: 'can only be unspaced letters and numbers' }
  validates :password_confirmation, presence: true

  has_many :reviews
  has_many :products, through: :reviews
  has_secure_password     #magic for hash encryption and validation
end
