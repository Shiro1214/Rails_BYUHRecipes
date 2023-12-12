require "test_helper"

class RecipesTest < ActionDispatch::IntegrationTest
  test "only show logged in user users' contributed recipes" do
    user = login_user
    recipe1 = FactoryBot.create :recipe, user: user
    recipe2 = FactoryBot.create :recipe, user: user
    recipe3 = FactoryBot.create :recipe
    
    visit root_path
    click_on user.name
    
    assert_text recipe1.name
    assert_text recipe2.name
    refute page.has_content?(recipe3.name)
  end
  
  test "only logged in user can see recipes" do
    visit root_path
    assert page.has_no_link?("Recipes", href: '/recipes')
    visit recipes_path

    assert_equal page.current_path, login_path
    assert_text "You need to login to view this page"
  end
  
  test "users can create recipe" do
    login_user
    visit recipes_path
    
    click_on "New Recipe"
    
    fill_in 'Name', with: "Newest Recipe"
    fill_in 'Budget', with: 10
    fill_in 'Servingsize', with: 4
    fill_in 'Preptime', with: 15
    fill_in 'Cooktime', with: 15
    fill_in 'Ingredients', with: "test ingredients"
    fill_in 'Storesavailable', with: "store"
    fill_in 'Cookingdirection', with: "Cook and eat"
    
    click_button "Create Recipe"
    
    assert_text "Recipe created."
    assert_text "Newest Recipe"

  end
  
  test "user can update recipe" do
    user = login_user
    recipe = FactoryBot.create :recipe, user: user
    
    visit recipes_path
    assert page.has_link?(recipe.name, href: recipe_path(recipe))
    
    click_link recipe.name
    click_button "Options"
    click_link "Edit Recipe"
    
    fill_in "Name", with: "Updated test recipe"
    click_button "Update Recipe"
    
    assert_equal page.current_path, recipe_path(recipe)
    assert_text "Recipe was updated."
    
  end 
  
  test "user can delete recipe" do
    user = login_user
    recipe = FactoryBot.create :recipe, user: user
    
    visit recipes_path
    assert page.has_link?(recipe.name, href: recipe_path(recipe))
    
    click_link recipe.name
    click_button "Options"
    click_link "Delete"
    
    assert_text "Are you sure to delete this recipe?"
    click_button "Yes"
    
    assert_equal page.current_path, recipes_path
    assert_text "Recipe ' " +  recipe.name +  " ' was deleted."
    refute page.has_link?(recipe.name, href: recipe_path(recipe))
  end 
end
