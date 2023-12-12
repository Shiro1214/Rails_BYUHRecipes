class User < ApplicationRecord
    has_many :recipes
    has_many :comments
    has_many :favorites, dependent: :destroy
    has_many :favorited_recipes, through: :favorites, source: :recipe
    has_one_attached :avatar
    has_secure_password
    validates :name, presence: :true
    validates :title, presence: :true
    validates :email, format: { with: /@/, message: "Must have an @"}, uniqueness: true
    
    def self.new_from_hash(user_hash) #sefl is static
        user = User.new user_hash
        user.password_digest = 0
        user
    end
    
    def has_password?
        self.password_digest.nil? || self.password_digest != '0'
    end 
end
