module StatisticsHelper
  include UsersHelper

  def visits_line_chart(visits, options)
    visits = visits.to_a
    visits.map! { |a| [a[0].to_date.to_s(:short), a[1]] }

    data = GoogleVisualr::DataTable.new
    data.new_column('string', 'Date')
    data.new_column('number', 'Visits')
    data.add_rows(visits)
    
    GoogleVisualr::Interactive::LineChart.new(data, options)
  end

  def country_pie_chart(visits, options)
    visits = visits.to_a
    visits.map! { |a| [country_name(a[0]), a[1]] }

    data = GoogleVisualr::DataTable.new
    data.new_column('string', 'Country')
    data.new_column('number', 'Visits')
    data.add_rows(visits)

    GoogleVisualr::Interactive::PieChart.new(data, options)
  end

  def age_pie_chart(visits, options)
    data = GoogleVisualr::DataTable.new
    data.new_column('string', 'Age Group')
    data.new_column('number', 'Visits')
    data.add_rows(visits)

    GoogleVisualr::Interactive::PieChart.new(data, options)
  end
end
