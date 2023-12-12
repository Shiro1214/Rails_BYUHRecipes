FactoryBot.define do
    #factory for user model
    factory :user do |f|
        f.sequence(:name) { |n| "Test User #{n}"}
        f.sequence(:email) { |n| "test#{n}@account.com"}
        f.title {"Test Chef"}
        f.role { "tester" }
        f.password {"password"}
        f.password_confirmation { |d| d.password}
    end
    
    factory :recipe do |f|
        f.sequence(:name) { |n| "Recipe test #{n}"}
        f.budget {10}
        f.servingSize {4}
        f.prepTime {15}
        f.cookTime {15}
        f.ingredients {"test ingredients"}
        f.storesAvailable {"store"}
        f.cookingDirection {"Cook and eat"}
        f.association :user
    end
end