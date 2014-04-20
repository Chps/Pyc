class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :user_must_be_signed_in
  helper_method :image_user_must_be_current_user
  helper_method :image_user_is_current_user?
  helper_method :user_is_current_user?
  helper_method :hide_breadcrumbs?
  helper_method :breadcrumbs
  def breadcrumbs
    crumbs = []
    # Find the indices of each '/' in the url.
    indices = request.fullpath.enum_for(:scan, /\//)
    indices = indices.map { Regexp.last_match.begin(0) }
    indices.push(request.fullpath.length - 1) unless indices.length == 1
    indices.each do |i|
      path = request.fullpath[0, i + 1]
      if path == '/'
        crumbs << {label: "Home", path: root_url}
      else
        crumbs << {label: path.split("/").last.humanize, path: path}
      end
    end
    crumbs.each_with_index do |c, i|
      if c[:label] == "Images"
        crumbs[i+1][:label] = Image.find(crumbs[i+1][:label].to_i).caption
      elsif c[:label] == "Users"
        crumbs[i+1][:label] = User.find(crumbs[i+1][:label].to_i).name
      end
    end
    crumbs
  end

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
