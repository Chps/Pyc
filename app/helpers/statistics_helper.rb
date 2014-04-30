module StatisticsHelper
  include CountryHelper

  def chart_visits(visits, options)
    visits = visits.to_a
    visits.map! { |a| [a[0].to_date.to_s(:short), a[1]] }

    data = GoogleVisualr::DataTable.new
    data.new_column('string', 'Date')
    data.new_column('number', 'Visits')
    data.add_rows(visits)

    GoogleVisualr::Interactive::LineChart.new(data, options)
  end

  def chart_countries(visits, options)
    visits = visits.to_a
    visits.map! { |a| [country_name(a[0]), a[1]] }

    data = GoogleVisualr::DataTable.new
    data.new_column('string', 'Country')
    data.new_column('number', 'Visits')
    data.add_rows(visits)

    GoogleVisualr::Interactive::PieChart.new(data, options)
  end

  def chart_ages(visits, options)
    visits = visits.to_a

    data = GoogleVisualr::DataTable.new
    data.new_column('string', 'Age Group')
    data.new_column('number', 'Visits')
    data.add_rows(visits)

    GoogleVisualr::Interactive::PieChart.new(data, options)
  end
end
