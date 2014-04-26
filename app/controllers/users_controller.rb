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

    views = @user.views_by_day
    if !views.empty?
      @view_chart = views_chart(views.keys, views.values, '400x300')
    end
  end

  private
    def views_chart(keys, values, size)
      x_labels = keys.map { |date| date.to_date.to_s(:short) }.sort
      y_range = [0, values.max, values.max / 5.0]
      Gchart.line(
        size:             size,
        data:             values,
        axis_with_labels: 'x,y',
        axis_labels:      [x_labels],
        axis_range:       [nil, y_range]
      )
    end
end
