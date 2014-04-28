module StatisticsHelper
  def visits_line_chart(visits, options)
    visits = visits.to_a
    visits.map! { |a| [a[0].to_date.to_s(:short), a[1]] }

    data = GoogleVisualr::DataTable.new
    data.new_column('string', 'Date')
    data.new_column('number', 'Visits')
    data.add_rows(visits)
    
    GoogleVisualr::Interactive::LineChart.new(data, options)
  end
end
