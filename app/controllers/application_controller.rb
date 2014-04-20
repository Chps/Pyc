class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :user_must_be_signed_in
  helper_method :image_user_must_be_current_user
  helper_method :image_user_is_current_user?
  helper_method :user_is_current_user?
  helper_method :hide_breadcrumbs?
  private
   def user_must_be_signed_in
     redirect_to new_user_session_path, alert: "You must sign in to access this page" unless current_user
   end
   def authenticate_user!
    if !current_user
      redirect_to root_url, :alert => 'You need to sign in for access to this page.'
    end
   end
   def image_user_must_be_current_user
     redirect_to root_url, :alert => 'Access denied.' unless image_user_is_current_user?
   end
   def image_user_is_current_user?
     return true if not params[:id]
     @image ||= Image.find(params[:id])
     current_user == @image.user
   end
   def user_is_current_user?
     current_user == @user
   end
   def hide_breadcrumbs?
     params[:action] == "index" and params[:controller] == "home" ? true : false
   end
end
