class UsersController < ApplicationController
  impressionist actions: [:show] #, unique: [:session_hash]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def statistics
    @user = User.find(params[:id])
    @impressions = Impression.where(
        "impressionable_type = 'User' and impressionable_id = ?",
        @user.id
        ).group(:user_id)
  end
end
