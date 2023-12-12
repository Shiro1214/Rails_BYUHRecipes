class Comment < ApplicationRecord
    has_rich_text :content
    belongs_to :recipe
    belongs_to :user
    validates :content, presence: true
    validates :rating, numericality: { greater_than: 0, less_than_or_equal_to: 10}
    #validates :user_id, numericality: { greater_than: 0}
end
