class User < ApplicationRecord
    has_many :tasks

    validates :name, presence: true, length: { maximum: 30 }

    before_validation { email.downcase! }
    validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true

    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, on: [ :create ]
end
