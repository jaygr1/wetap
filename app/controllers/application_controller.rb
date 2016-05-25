class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
     return nil unless session[:current_user_uuid].present?
     @current_user ||= User.find(session[:current_user_uuid])
   end
  #  helper_method :current_user

   def require_user
     if current_user.nil?
       flash[:error] = "Login To Continue"
       redirect_to :root and return
     end
   end
end
