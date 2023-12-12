class CommentsController < ApplicationController
  before_action :authenticate
  before_action :load_recipe
  before_action :load_comment, except: [:new, :index, :create]
  def index
  end
  def new
    @comment = Comment.new
  end
  def create
    @comment = Comment.new comment_params #the params are created from new's form
    @comment.user = current_user
    if @recipe.comments << @comment #successfully created and added
      redirect_to recipe_comment_path(@recipe,@comment), notice: "Comment Created" #recipe_comment_path(@recipe,@comment)
    else
      #calling new -> new form
      render :new, status: :unprocessable_entity
    end
  end
  def show
    
  end

  def edit
    if unauthorized
      redirect_to recipe_comment_path(@recipe,@comment), alert: "Invalid Request"
    end
  end
  
  def update
    if unauthorized
      redirect_to recipe_comment_path(@recipe,@comment), alert: "Invalid Request"
    else 
      if @comment.update comment_params
        redirect_to recipe_comment_path(@recipe,@comment), notice: "Comment Updated"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end 
  def destroy
    if unauthorized
      redirect_to recipe_comment_path(@recipe,@comment), alert: "Invalid Request"
    else
      @comment.destroy
      #render :index this wouldn't work since you need to pass it recipe to load :)
      redirect_to @recipe, alert: "Comment deleted" #recipe_comments_path(@recipe)
    end
  end
  private
  def unauthorized
    current_user != @comment.user
  end
  def comment_params
    params.require(:comment).permit(:content, :user_id,:rating)
  end 
  def load_comment
    @comment = @recipe.comments.find params[:id] #only find within comments belong to specific recipe
  end
  def load_recipe
    @recipe = Recipe.find params[:recipe_id] # the params receive from an action, referring to recipe_id
  end
end
