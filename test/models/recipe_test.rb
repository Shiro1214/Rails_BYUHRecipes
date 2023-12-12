require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  test "has a valid factory" do
    recipe = FactoryBot.build :recipe
    
    assert recipe.valid?
  end
  
  test "requires a user" do
    recipe = FactoryBot.build :recipe
    recipe.user = nil
    
    refute recipe.valid?
  end
  
  test "requires a name" do
      recipe = FactoryBot.build :recipe
      recipe.name = ""
      
      refute recipe.valid?
  end 
end
