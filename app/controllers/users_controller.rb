class UsersController < ApplicationController
  include UsersHelper
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

    visits = @user.visits_by_day.to_a
    visits.map! { |a| [a[0].to_date.to_s(:short), a[1]] }

    options = { width: 500, heigth: 200, is3D: true }

    @visits_chart = LineChart.new(visits_data(visits), options)

    visits_by_country = @user.visits_by_country.to_a
    visits_by_country.map! { |a| [country_name(a[0]), a[1]] }

    @country_pie_chart = PieChart.new(country_data(visits_by_country), options)
  end

  private
    def visits_data(visits)
      data = DataTable.new
      data.new_column('string', 'Date')
      data.new_column('number', 'Visits')
      data.add_rows(visits)
      data
    end

    def country_data(visits)
      data = DataTable.new
      data.new_column('string', 'Country')
      data.new_column('number', 'Visits')
      data.add_rows(visits.to_a)
      data
    end
end
