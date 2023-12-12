class FavoritesController < ApplicationController
  before_action :authenticate
  before_action :load_recipe, except: [:index]
  
  def index
    @favorite_recipes = current_user.favorited_recipes
  end

  def create
    if current_user.favorited_recipes << @recipe
      redirect_back_or_to recipes_path, notice: 'Recipe added to favorites!'
    else
      redirect_back_or_to @recipe, alert: 'failed to add fav'
    end
  end

  def destroy
    if current_user.favorited_recipes.delete(@recipe)
      redirect_back_or_to recipes_path, notice: 'Recipe removed from favorites!'
    else
      redirect_back_or_to @recipe, alert: 'Invalid request'
    end
  end

  private

  def load_recipe
    @recipe = Recipe.find params[:recipe_id] # the params receive from an action, referring to recipe_id
  end
  
end
