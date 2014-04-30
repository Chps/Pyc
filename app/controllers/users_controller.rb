class UsersController < ApplicationController
  include StatisticsHelper

  before_action :set_user
  before_action :user_must_be_current_user, only: [:statistics]

  impressionist actions: [:show] #, unique: [:session_hash]

  def show
  end

  def statistics
    options = { width: 500, height: 200, is3D: true }

    # Profile stats
    @user_visits_chart = chart_visits(@user.visits_by_day, options)
    @user_country_chart = chart_countries(@user.visits_by_country, options)
    @user_age_chart = chart_ages(@user.visits_by_age, options)

    # Combined images stats
    @images_visits_chart = chart_visits(@user.images_visits_by_day, options)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_must_be_current_user
      redirect_to root_url, alert: 'Access denied.' unless user_is_current_user?
    end
end
