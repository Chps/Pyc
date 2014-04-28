module Stats
  extend ActiveSupport::Concern

  def visits_by_day(viewable)
    created_at = 'DATE(created_at)'
    viewable.impressions.select(created_at).group(created_at).order(created_at).count
  end

  def visits_by_country(viewable)
    viewable
      .impressions
      .joins('INNER JOIN users ON user_id = users.id')
      .select(:country)
      .where.not('users.country' => nil, 'users.country' => '')
      .group(:country)
      .count
  end
end
