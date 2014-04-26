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
    views = @user.views_by_day

    if !views.empty?
      x_labels = views.keys.map { |date| date.to_date.to_s(:short) }.sort
      values = views.values
      y_range = [0, values.max, values.max / 5.0]
      @view_chart = Gchart.line(
                      size: '400x300',
                      data: views.values,
                      axis_with_labels: 'x,y',
                      axis_labels: [x_labels],
                      axis_range: [nil, y_range]
                    )
    end
  end
end
