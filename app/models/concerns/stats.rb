module Stats
  extend ActiveSupport::Concern

  def visits_by_day(viewable)
    created_at = 'DATE(created_at)'
    viewable.impressions.select(created_at).group(created_at).order(created_at).count
  end
end
