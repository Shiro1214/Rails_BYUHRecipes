class RecipesController < ApplicationController
  before_action :authenticate
  before_action :load_recipe, except: [:new, :index, :create] #before action is for before calling any method
  #HTTP: GET
  #Path: /recipes
  def index 
    @recipes = Recipe.all
  end
  #HTTP: GET
  #PATH: /recipes/new
  def new
    @recipe = Recipe.new
  end
  #HTTP: POST
  #PATH: /recipes
  def create
    @recipe = Recipe.new recipe_params
    @recipe.user = current_user #create by current user
    if @recipe.save
      redirect_to recipes_path, notice: "Recipe created."
    else
      render :new, status: :unprocessable_entity
    end
  end
  #HTTP: GET
  #PATH: /recipes/:id
  #This method get called by the routes then it pass params to html views or get params from previous post views.
  def show
   
  end
  #HTTP: GET
  #PATH: /recipes/:id/edit
  def edit
    if unauthorized
      redirect_to recipes_path, alert: "Invalid Request"
    end
  end
  #HTTP: DELETE
  #PATH: /recipes/:id
  def destroy
    if unauthorized
      redirect_to @recipe, alert: "Invalid Request"
    else
      @recipe.destroy
      redirect_to recipes_path, alert: "Recipe ' #{@recipe.name} ' was deleted."
    end
  end
  #HTTP: PATCH/PUT
  #PATH: /recipes/:id
  def update
    if unauthorized
      redirect_to @recipe, alert: "Invalid Request"
    else 
      if @recipe.update recipe_params
        redirect_to @recipe, notice: "Recipe was updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end
  
  private
  def unauthorized
    current_user != @recipe.user
  end
  def load_recipe
    @recipe = Recipe.find params[:id] # is this param from the view? query? -> controller -> another view?
  end
  def recipe_params
    params.require(:recipe).permit(:name,:imgUrl,:servingSize,:budget,:prepTime,:cookTime,:ingredients,:storesAvailable,:cookingDirection, :image)
  end  
end
