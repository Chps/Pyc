class UsersController < ApplicationController
  include StatisticsHelper
  include GoogleVisualr
  include GoogleVisualr::Interactive

  impressionist actions: [:show] #, unique: [:session_hash]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def statistics
    @user = User.find(params[:id])

    options = { width: 500, height: 200, is3D: true }

    @visits_chart = visits_line_chart(@user.visits_by_day, options)
    @country_pie_chart = country_pie_chart(@user.visits_by_country, options)

    visits_by_age = @user.visits_by_age

    @age_pie_chart = PieChart.new(age_data(visits_by_age), options)
  end

  private
    def country_data(visits)
    end

    def age_data(visits)
      data = DataTable.new
      data.new_column('string', 'Age Group')
      data.new_column('number', 'Visits')
      data.add_rows(visits)
      data
    end
end
