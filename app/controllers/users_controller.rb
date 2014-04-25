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
    @impressions = @user.views(select: 'user_id').group(:user_id)
  end
end
