class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate, except: [:new, :create]
  before_action :load_user, except: [:new, :create] #before action is for before calling any method
  def new
    if session[:user_hash]
      @user = User.new_from_hash session[:user_hash]
      @user.valid?
    else
      @user = User.new
    end
  end
  def create
    if session[:user_hash]
      @user = User.new_from_hash session[:user_hash]
      @user.name = user_params[:name]
      @user.email = user_params[:email]
      @user.title = user_params[:title]
      @user.role = user_params[:role]
    else
      @user = User.new user_params
    end
    if @user.save
      login(@user)
      session[:user_hash] = nil
      redirect_to root_path, notice: "You are successfully sign up."
    else
      render :new, status: :unprocessable_entity
    end
  end
  def show
  end
  def edit
    if unauthorized
      redirect_to user_path(@user), alert: "You are not authorized to edit"
    end
  end
  def update
    if unauthorized
      redirect_to user_path(@user), alert: "You are not authorized to edit"
    else
      update_params = user_password_params
      if not @user.has_password?
         update_params = user_password_params.except(:password,:password_confirmation,:password_challenge)
      end
      if @user.update update_params
        redirect_to @user, notice: "You have successfully updated your info"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end
  def destroy
    if unauthorized
      redirect_to root_path, alert: "Invalid Request"
    else
      @user.destroy
      logout
      redirect_to login_path, alert: "User: ' #{@user.name} ' was deleted."
    end
  end 
  private
  def unauthorized
    current_user != @user
  end
  def user_params
   params.require(:user).permit(:name,:email,:password,:password_confirmation,:title,:role,:avatar)
  end
  def user_password_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:password_challenge,:title,:role,:avatar).with_defaults(password_challenge: '')
  end
  def load_user
    @user = User.find params[:id]
  end
  
end
