class UsersController < ApplicationController
  include UsersHelper

  impressionist actions: [:show] #, unique: [:session_hash]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def statistics
    @user = User.find(params[:id])

    visits = @user.visits_by_day
    if !visits.empty?
      values = visits.values
      steps = values.max > 5 ? 5 : values.max
      @visits_chart = visits_line_chart(visits.keys, values, values.max.round_up,
                                        steps, '500x200')
    end

    visits_by_country = @user.visits_by_country
    if !visits_by_country.empty?
      keys = visits_by_country.keys.map { |key| country_name(key) }
      values = visits_by_country.values
      labels = values.map { |val| (val * 100.0 / values.sum).round(2).to_s + '%' }
      @country_pie_chart = country_pie_chart(keys, values, labels, '500x200')
    end
  end

  private
    def visits_line_chart(keys, values, max, steps, size)
      x_labels = keys.map { |date| date.to_date.to_s(:short) }
      y_range = [0, max, max / steps]
      Gchart.line(
        size:             size,
        data:             values,
        axis_with_labels: 'x,y',
        axis_labels:      [x_labels, nil],
        axis_range:       [nil, y_range],
        max_value:        max
      )
    end

    def country_pie_chart(keys, values, labels, size)
      Gchart.pie_3d(
        size:   size,
        data:   values,
        legend: keys,
        labels: labels
      )
    end
end
