class UsersController < ApplicationController
  impressionist actions: [:show] #, unique: [:session_hash]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

end
