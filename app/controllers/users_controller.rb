class UsersController < ApplicationController
  include StatisticsHelper

  before_action :set_user
  before_action :user_must_be_current_user, only: [:statistics]

  impressionist actions: [:show] #, unique: [:session_hash]

  def show
  end

  def statistics
    options = { width: 500, height: 200, is3D: true }

    @visits_chart = visits_line_chart(@user.visits_by_day, options)
    @country_pie_chart = country_pie_chart(@user.visits_by_country, options)
    @age_pie_chart = age_pie_chart(@user.visits_by_age, options)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_must_be_current_user
      redirect_to root_url, alert: 'Access denied.' unless user_is_current_user?
    end
end
