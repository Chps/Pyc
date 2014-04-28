class UsersController < ApplicationController
  include StatisticsHelper

  impressionist actions: [:show] #, unique: [:session_hash]

  def show
    @user = User.find(params[:id])
  end

  def statistics
    @user = User.find(params[:id])

    options = { width: 500, height: 200, is3D: true }

    @visits_chart = visits_line_chart(@user.visits_by_day, options)
    @country_pie_chart = country_pie_chart(@user.visits_by_country, options)
    @age_pie_chart = age_pie_chart(@user.visits_by_age, options)
  end
end
