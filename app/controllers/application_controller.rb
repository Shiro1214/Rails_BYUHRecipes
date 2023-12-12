class ApplicationController < ActionController::Base
    
    private #can be called from other controllers
    def authenticate
        if !current_user
            session[:protected_page] = request.url
            redirect_to login_path, alert: "You need to login to view this page"
        end
    end
    def authorize
        current_user.role == 'Admin'
    end
    def login(user)
        session[:user_id] = user.id
    end
    
    def logout
        session[:user_id] = nil
    end
    def current_user
    @current_user ||= User.find session[:user_id] if session[:user_id]
    #if @current_user
      #@current_user
    #elsif session[:user_id]
      #@current_user = User.find session[:user_id]
    #end
    end
    helper_method :current_user #this allows view to call the method
end
