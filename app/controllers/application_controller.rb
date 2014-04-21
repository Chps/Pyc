class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :user_must_be_signed_in
  helper_method :image_user_must_be_current_user
  helper_method :image_user_is_current_user?
  helper_method :user_is_current_user?

  private
    def convert(map, type)
      if type == :image
        image = Image.find map[:label].to_i
        return { label: image.caption, path: image_url(image) }
      else
        user = User.find map[:label].to_i
        return { label: user.name, path: user_url(user) }
      end
    end

    def user_must_be_signed_in
      redirect_to new_user_session_path, alert: "You must sign in to access this page" unless current_user
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
end
