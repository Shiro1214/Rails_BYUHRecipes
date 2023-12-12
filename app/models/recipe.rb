class Recipe < ApplicationRecord
    has_one_attached :image
    has_many :favorites, dependent: :destroy
    has_many :fans, through: :favorites, source: :user
    has_many :comments, :dependent => :destroy
    belongs_to :user
    validates :name, presence: true
    validates :budget, presence: true
    validates :ingredients, presence: true
    validates :cookingDirection, presence: true
    validates :storesAvailable, presence: true
    validates :servingSize, numericality: { greater_than: 0 }
    validates :prepTime, comparison: { greater_than: 0 }
    validates :cookTime, comparison: { greater_than: 0 }
end
